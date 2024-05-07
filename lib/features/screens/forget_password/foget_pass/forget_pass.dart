import 'package:e_commerce/features/screens/forget_password/foget_pass/component/body.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatelessWidget {

  static const String routeName = '/forgetPass';

  const ForgetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(      backgroundColor: Colors.white,

      body: Body(),
    );

  }
}
