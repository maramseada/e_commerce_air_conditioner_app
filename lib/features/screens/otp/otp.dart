import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/constant/images.dart';
import 'package:e_commerce/core/constant/navigator.dart';
import 'package:e_commerce/features/screens/sign_up/complete_data.dart';
import 'package:e_commerce/features/screens/sign_up/register.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

import '../../../api/api.dart';
import '../../../models/user.dart';
import '../forget_password/foget_pass/forget_pass.dart';
import '../forget_password/new_pass/new_pass.dart';

class Otp extends StatefulWidget {
  String email;
  String? name;
  Otp({super.key, required this.email, this.name});

  static final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFF1F1F1),
    ),
  );

  static final focusedPinTheme =
      defaultPinTheme.copyDecorationWith(shape: BoxShape.circle, color: Color(0xFFF1F1F1), border: Border.all(color: kPrimaryColor));

  static final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(color: Colors.black, border: Border.all(color: Colors.transparent)),
  );

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _api = Api();

  final _formKey = GlobalKey<FormState>();

  bool isverifying = false;
  bool isChecking = false;
  List<String> errors = [];
  String? pin;

  TextEditingController pinController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSpinAnimation() {
    _controller.forward(from: 0.0);
  }

  String? previousRouteName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    previousRouteName = ModalRoute.of(context)?.settings.name;

    return Scaffold(      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: size.height * 0.06),
              width: double.infinity,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                  color: Color(0xffCA70090A).withOpacity(0.04),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30))),
              child: Transform.scale(
                scale: size.width * 0.0013,
                child: Image.asset(
                  otp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
                right: size.width * 0.04,
                left: size.width * 0.04,
              ),
              child: Column(
                children: [
                  Text(
                    'كود التحقق',
                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.06),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'قم بكتابة كود التحقق المكون من 5 أرقام الذي ',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.045,
                      color: Color(0xff2D2525),
                    ),
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.045,
                      color: Color(0xff2D2525),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        onChanged: (value) {
                          pin = value;
                        },
                        controller: pinController,
                        length: 5,
                        defaultPinTheme: Otp.defaultPinTheme,
                        focusedPinTheme: Otp.focusedPinTheme,
                        submittedPinTheme: Otp.submittedPinTheme,
                        validator: (s) {
                          // return s == '2222' ? null : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                      )),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  GestureDetector(
                    onTap: () {

                      String? previousRouteName =widget.name;

                      if (widget.name == 'forget') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewPass(email: widget.email, otp: pin!,)));
                        print('emaill${widget.email}');
                        print('pinnnn $pin');
                      } else if (widget.name ==  'register') {
                        checkOtp();
                      } else {
                        print(previousRouteName);
                        print('failed');
                      }
                    },
                    child: Button(text: 'تحقق'),
                  ),

                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Text(
                    'لم يتم إرسال كود التحقق ؟',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.042,
                      color: Color(0xff929292),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  GestureDetector(
                      onTap: (){
                        sendOtp();
                        _startSpinAnimation();
                      },
                      child:  isverifying
                          ? Column(
                        children: [
                          AnimatedBuilder(
                              animation: _controller,
                              builder: (BuildContext context, Widget? child) {
                                return Transform.rotate(
                                  angle: _controller.value * 2 * 3.1415,
                                  child: Image.asset(
                                    linear,
                                    width: size.width * 0.09,
                                  ),
                                );
                              }),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            'أرسل الكود مرة أخرى',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w700,
                              fontSize: size.width * 0.042,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ):
                      Column(
                        children: [
                          Image.asset(
                            linear,
                            width: size.width * 0.09,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            'أرسل الكود مرة أخرى',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w700,
                              fontSize: size.width * 0.042,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ) )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendOtp() async {

    setState(() {
      isverifying = true;
      pin = pinController.text;

    });

    try {
      Map<String, dynamic>? response = await _api.sendOtp(widget.email);
      print('this i semail ${widget.email}');
      if (response != null && response['status'] == 200) {
        print('OTP is Sent');

      } else {
        if (response != null && response['message'] != null) {
          setState(() {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
          });
        }
      }
    } catch (e) {
      print('Network Error: $e');
      setState(() {
        errors = ['Network error occurred. Please check your connection.'];
      });
    } finally {
      setState(() {
        isverifying = false;
      });
    }
  }

  void checkOtp() async {
    // User user = User(
    //   email: widget.email,
    // );

    setState(() {
      isChecking = true;
      pin = pinController.text;
    });

    try {
      Map<String, dynamic>? response = await _api.checkOtp(widget.email, pin!);
      print('this i semail ${widget.email} ');
      if (response != null && response['status'] == 200) {
        print('navigate otp');
        navigateTo(context, CompleteData(otp: pin!,emaill: widget.email,));

        print('after navigateTo');
      } else {
        if (response != null && response['message'] != null) {
          setState(() {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
          });
        }
      }
    } catch (e) {
      print('Network Error: $e');
      setState(() {
        errors = ['Network error occurred. Please check your connection.'];
      });
    } finally {
      setState(() {
        isChecking = false;
      });
    }
  }
}
