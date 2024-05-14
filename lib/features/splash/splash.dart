import 'dart:async';
import 'package:e_commerce/features/splash/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/navigator.dart';
import '../screens/sign_up/register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => navigateTo(context, Register()));
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: Colors.white,
      body:SplashViewBody(),
    );
  }
}
