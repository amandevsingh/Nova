import 'package:flutter/material.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    Key key,
    this.progressColor,
  }) : super(key: key);
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: progressColor ?? custThemeColor,
      ),
      child: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
