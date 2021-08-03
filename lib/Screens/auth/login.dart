import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/home_screen.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obSecureText = true;

  TextEditingController emailController = TextEditingController();

  TextEditingController passWordController = TextEditingController();

  FocusNode emailNode = FocusNode();

  FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return loginBody(context);
  }

  Widget loginBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Column(
        children: [
          TextFormField(
            focusNode: emailNode,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(passwordNode);
            },
            decoration: InputDecoration(
                hintText: "Email or Mobile",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: custThemeColor.withOpacity(0.6),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                )),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            obscureText: obSecureText,
            focusNode: passwordNode,
            controller: passWordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: obSecureText
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              ImgName.openEye,
                              height: 20,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              ImgName.closeEye,
                              height: 20,
                            ),
                          ),
                    onTap: () {
                      setState(() {
                        obSecureText = !obSecureText;
                      });
                    }),
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: custThemeColor.withOpacity(0.6),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          buildLoginButton()
        ],
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            custThemeColor,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(),
            ),
          );
        },
        child: Text(
          "SIGN IN",
        ),
      ),
    );
  }
}
