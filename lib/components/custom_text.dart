import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txtTitle;
  final TextStyle style;
  final TextAlign align;
  final int maxLine;
  final TextOverflow textOverflow;
  final void Function() onPressed;

  CustomText(
      {this.txtTitle,
      this.style,
      this.align = TextAlign.start,
      this.maxLine,
      this.textOverflow,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(
      txtTitle,
      style: style,
      softWrap: true,
      textAlign: align,
      maxLines: maxLine,
      overflow: textOverflow,
    );
    return onPressed == null
        ? textWidget
        : TextButton(onPressed: onPressed, child: textWidget);
  }
}
