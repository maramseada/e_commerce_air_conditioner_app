import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../api/api.dart';
import '../../../../../constant/colors.dart';
import '../../../../../constant/images.dart';
import '../../../../../constant/navigator.dart';
import '../../../../../utilities/shared_pref.dart';
import '../../../../../widgets/button.dart';
import '../../../otp/otp.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool progress = false;
  TextEditingController emailController = TextEditingController();
  String? email;
  List<String> errors = [];
  final _api = Api();
  final _formKey = GlobalKey<FormState>();
  String? errorEmail;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      reverse: true,
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
                smsNotification,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.01,
              right: size.width * 0.04,
              left: size.width * 0.04,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(children: [
              Text(
                'هل نسيت كلمة المرور ؟',
                style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.06),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'قم بإدخال بريدك الإلكتروني لإرسال كود',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.045,
                  color: Color(0xff2D2525),
                ),
              ),
              Text(
                'التحقق',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.045,
                  color: Color(0xff2D2525),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: size.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFFF7F7F7),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                errorEmail = 'برجاء ادخال البريد الالكتروني';
                              });
                              return null;
                            }
                            if (!emailRegex.hasMatch(value)) {
                              setState(() {
                                errorEmail = 'برجاء ادخال بريد الكتروني صحيح';
                              });
                              return null;
                            } else {
                              setState(() {
                                errorEmail = null;
                              });
                              return null;
                            }
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'البريد الاكتروني',
                            hintStyle: TextStyle(
                              color: grayColor,
                              fontSize: size.width * 0.04,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w700,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF7F7F7),
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF7F7F7),
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF7F7F7),
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF7F7F7),
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: size.width * 0.035,
                        ),
                        child: SvgPicture.asset('assets/images/Linedivider.svg'),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: size.width * 0.035,
                          right: size.width * 0.01,
                        ),
                        child: SvgPicture.asset('assets/images/emaildelete.svg', width: 30),
                      ),
                    ],
                  ),
                ),
              ),
              if (errorEmail != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorEmail!,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red,   fontFamily: 'Almarai',
                    ),
                  ),
                ),
              SizedBox(
                height: size.height * 0.04,
              ),
              GestureDetector(
                  onTap: progress ? null : sendOtp,
                  child: progress
                      ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      strokeWidth: 2,
                    ),
                  )
                      : Button(text: 'إرسال', inProgress: progress)),
            ]),
          ),
        ],
      ),
    );

  }

  void sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        progress = true;
        email = emailController.text;
      });

      try {
        Map<String, dynamic>? response = await _api.sendOtp(email!);

        print('this i semail ${email!}');
        if (response != null && response['status'] == 200) {
          print('================================================OTP is Sent');

          navigateTo(
              context,
              Otp(
                email: email!,
                name: 'forget',
              ));
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
          progress = false;
        });
      }
    }
  }
}
