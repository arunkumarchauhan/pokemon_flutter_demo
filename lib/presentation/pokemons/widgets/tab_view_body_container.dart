import 'package:flutter/material.dart';

class TabViewBodyContainer extends StatelessWidget {
  TabViewBodyContainer({required this.child, Key? key}) : super(key: key);
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black38, Colors.black])),
      child: child,
    );
  }
}
