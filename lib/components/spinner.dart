import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    Key? key,
    required this.progressColor,
  }) : super(key: key);
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: progressColor,
        ),
      ),
    );
  }
}
