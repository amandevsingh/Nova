import 'package:flutter/material.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class CustomDropDown extends StatefulWidget {
  final ValueSetter<String> callback;
  final List<CustomDropDownItems> items;
  final double height;
  final double width;
  final String value;
  final String hintText;
  final String currentText;

  CustomDropDown(
      {this.items,
      this.height,
      this.currentText,
      this.width,
      this.value,
      this.hintText = "",
      this.callback});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  void show() {
    showDialog(
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        content: SizedBox(
          width: double.maxFinite,
          height: widget.height,
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return TextButton(
                  style: widget.items[index].label == widget.currentText
                      ? TextButton.styleFrom(
                          backgroundColor: Color(0xFFf082ac),
                          padding: EdgeInsets.only(
                              top: 8.0, left: 15.0, right: 8.0, bottom: 8.0))
                      : TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.only(
                              top: 8.0, left: 15.0, right: 8.0, bottom: 8.0)),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.items[index].label,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(fontWeight: FontWeight.w400))),
                  onPressed: () {
                    widget.callback(widget.items[index].value);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ),
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  widget.value ?? widget.hintText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: RotatedBox(
                quarterTurns: 3,
                child: Image.asset(
                  ImgName.back,
                  height: 11.0,
                  width: 7.0,
                  color: Color(0xFFAEADAD),
                ),
              ),
            ),
          ],
        ),
        onTap: show,
      ),
    );
  }
}

class CustomDropDownItems {
  final String label;
  final String value;
  final String currentIndex;

  CustomDropDownItems(this.label, this.value, this.currentIndex);
}
