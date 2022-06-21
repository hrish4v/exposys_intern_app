import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CircularAva extends StatelessWidget {
  final String img;
  const CircularAva({required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      child: Image.asset(
        img,
        color: Colors.lightBlue,
      ),
    );
  }
}
