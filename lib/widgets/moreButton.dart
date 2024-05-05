import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/colors.dart';

class moreButton extends StatefulWidget {
  Color color;
  String text;
  String? icon;
  Color TextColor;
  moreButton({super.key, required this.color, required this.text, this.icon, required this.TextColor});

  @override
  State<moreButton> createState() => _moreButtonState();
}

class _moreButtonState extends State<moreButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        width: size.width * 0.9,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.color,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              widget.icon!,
              width: size.width * 0.07,
            ),
            SizedBox(width: 15,),
            Text(
              widget.text,
              style: TextStyle(
                color: widget.TextColor,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
                fontSize: size.width * 0.04,
              ),
            ),
          ],
        ));
  }
}
