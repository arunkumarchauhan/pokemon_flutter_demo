import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  ChipWidget(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.borderColor})
      : super(key: key);
  Color borderColor;
  Color textColor;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(color: borderColor, width: 2)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 18),
      ),
    );
  }
}
