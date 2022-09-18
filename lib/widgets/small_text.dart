import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  // TextOverflow overflow;
  SmallText({Key? key, this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2
     // this.overflow = TextOverflow.ellipsis
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // overflow: overflow,
      style: TextStyle(
          fontFamily: 'Roboto',
          color:color,
          fontSize: size,
          height: height
          // fontWeight: FontWeight.w400
      ),
    );
  }
}
