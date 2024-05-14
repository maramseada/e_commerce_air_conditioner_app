import 'package:flutter/material.dart';

import '../../../../core/constant/images.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Color(0xFF035B97),
            Color(0xFF1D75B1),
          ],
          stops: [0.2509, 0.8776],
        ),
      ),
      child: Image.asset(logo,scale: size.width*0.015),
    );
  }
}
