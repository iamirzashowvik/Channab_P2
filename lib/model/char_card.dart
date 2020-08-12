import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class Char_card extends StatelessWidget {
  Char_card({this.name, this.cc});
  final Color cc;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: cc,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: TextResponsive(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          )),
        ),
      ),
    );
  }
}
