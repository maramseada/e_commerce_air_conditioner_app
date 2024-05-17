import 'package:e_commerce/core/constant/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final bool inProgress;

  const Button({super.key, required this.text, this.inProgress = false});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,

      decoration: BoxDecoration(color: widget.inProgress ? kPrimaryColorDark : kPrimaryColor, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: widget.inProgress
            ? const CircularProgressIndicator()
            : Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.05,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
