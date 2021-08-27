import 'package:flutter/material.dart';
import 'package:flutter_auth/components/constants.dart';
import 'package:flutter_auth/components/text_field_container.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText:hintText,
          // icon: Icon(
          //   Icons.lock,
          //   color: kPrimaryColor,
          // ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Color(0xFF821541),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
