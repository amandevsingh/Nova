import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/src/platform_specifics/android/enums.dart'
    as Priority;
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/home/home_screen.dart';
import 'package:flutter_auth/components/text_style_decoration.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/auth/welcome_screen.dart';
import 'Screens/home/notification_screen.dart';
import 'api/api.dart';
import 'components/img_color_static_strings.dart';

class MyApp extends StatefulWidget {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  MyAppState createState() => MyAppState();
}

const _kShouldTestAsyncErrorOnInit = false;

// Toggle this for testing Crashlytics in your app locally.
const _kTestingCrashlytics = true;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void showNotification(String title, String body) async {
  await _demoNotification(title, body);
}

Future<void> _demoNotification(String title, String body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID', 'channel name', 'channel description',
      icon: "@mipmap/nova1",
      importance: Importance.high,
      playSound: true,
      showProgress: true,
      styleInformation: BigTextStyleInformation(''),
      priority: Priority.Priority.high,
      ticker: 'test ticker');

  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: 'test');
}

Future<void> main() async {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message?.messageId}");
    showNotification(message.notification.title, message.notification.body);
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//  runApp(TwilioProgrammableVideoExample());

  runZonedGuarded(() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    runApp((MyApp()));
  }, FirebaseCrashlytics.instance.recordError);
}

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();
// Crude counter to make messages unique
int _messageCount = 0;

// ignore: must_be_immutable
class MyAppState extends State<MyApp> {
  String _twilioToken;
  Future<void> _initializeFlutterFireFuture;
  String _token;
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize

    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };

    if (_kShouldTestAsyncErrorOnInit) {
      //await _testAsyncErrorOnInit();
    }
  }

  Future<dynamic> onSelectNotification(String payload) async {
    /*Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(payload),
        content: Text("Payload: $payload"),
      ),
    );
  }

  @override
  Future<void> initState() {
    super.initState();
    try {
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/nova1');
      var initializationSettingsIOS = new IOSInitializationSettings();
      var initializationSettings = new InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);

      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);
      var settings = FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage message) {
        if (message != null) {
          print('A new onMessageOpenedApp event was getInitialMessage!');
        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        showNotification(message.notification.title, message.notification.body);
        print('A new onMessageOpenedApp event was android!');
        if (notification != null && android != null) {}
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(HomeScreen.navState.currentContext).push(
              MaterialPageRoute(builder: (context) => NotificationScreen()));
        });

        // print('A new onMessageOpenedApp event was published!');
      });
      // use the returned token to send messages to users from your custom server

      connectivitySubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult connectivityResult) {
        if (connectivityResult == ConnectivityResult.none) {
        } else if (_previousResult == ConnectivityResult.none) {}
        _previousResult = connectivityResult;
      });

      _initializeFlutterFireFuture = _initializeFlutterFire();
    } catch (errr) {}
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nova IVF',
      theme: ThemeData(
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
          // canvasColor: Colors.transparent,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          unselectedWidgetColor: custThemeColor,
          textTheme: TextStyleDecoration.lightTheme),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  Future<void> doLoad() async {
    var value;
    try {
      value = await Cognito.initialize();
    } catch (e, trace) {
      print(e);
      print(trace);

      if (!mounted) return;

      return;
    }

    if (!mounted) return;
  }

  @override
  void dispose() {
    Cognito.registerCallback(null);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    doLoad();
    Cognito.registerCallback((value) {
      if (!mounted) return;
    });
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    var prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool(IS_LOGGED_IN) ?? false;
    if (status) {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } else {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen()));

      // await Navigator.of(context).pushReplacement(MaterialPageRoute(
      // builder: (BuildContext context) => Onboardingnewuser1()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff90244c),
        child: Center(
            child: Image.asset(
          "assets/images/nova-ivf-white.png",
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height,
        )));
  }
}
