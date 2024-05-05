import 'package:e_commerce/constant/navigator.dart';
import 'package:e_commerce/presentation/screens/forget_password/foget_pass/forget_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../api/api.dart';
import '../../../constant/colors.dart';
import '../../../constant/images.dart';
import '../../../utilities/shared_pref.dart';
import '../../../widgets/button.dart';
import '../../BottomBar/BottomBar.dart';
import '../sign_up/register.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? email;
  String? password;
  bool _passwordVisible = false;
  bool progress = false;
  List<String> errors = [];
  final _api = Api();
  final _formKey = GlobalKey<FormState>();
  String? errorEmail;
  String? errorPass;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.13,
                  right: size.width * 0.04,
                  left: size.width * 0.04,
                ),
                child: Column(
                  children: [
                    Image.asset(logoTitle, scale: size.width * 0.01),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.057),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      'قم بإدخال بريدك الإلكتروني لتسجيل ',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.045,
                        color: grayColor,
                      ),
                    ),
                    Text(
                      'الدخول ',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.045,
                        color: grayColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
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
                                children: [ Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.035,
                                    right: size.width * 0.01,
                                  ),
                                  child: SvgPicture.asset('assets/images/emaildelete.svg', width: 30),
                                ), Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.035,
                                  ),
                                  child: SvgPicture.asset('assets/images/Linedivider.svg'),
                                ),
                                  Expanded(
                                    child: TextFormField(
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


                                ],
                              ),
                            ),

                            // Display error message outside the container
                            if (errorEmail != null)
                              Text(
                                errorEmail!,
                                style: TextStyle(
                                  color: Colors.red, fontFamily: 'Almarai',
                                  // Adjust color as needed
                                ),
                              ),

                            Container(
                              margin: EdgeInsets.only(
                                top: size.height * 0.02,
                                left: size.width * 0.02,
                                right: size.width * 0.02,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: size.width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(38),
                                color: Color(0xFFF7F7F7),
                              ),
                              child: Row(
                                children: [ Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.035,
                                    right: size.width * 0.01,
                                  ),
                                  child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                                ), Container(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.035,
                                  ),
                                  child: SvgPicture.asset('assets/images/Linedivider.svg'),
                                ),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            errorPass = 'برجاء ادخال كلمة المرور';
                                          });
                                          return null;
                                        }
                                        if (value.length < 8) {
                                          setState(() {
                                            errorPass = 'كلمة المرور يجب أن تكون 8 رموز على الأقل';
                                          });
                                          return null;
                                        } else {
                                          setState(() {
                                            errorPass = null;
                                          });
                                          return null;
                                        }
                                      },
                                      obscureText: !_passwordVisible,
                                      controller: passController,
                                      decoration: InputDecoration(
                                        hintText: 'كلمة المرور الحالية',
                                        hintStyle: TextStyle(
                                          color: grayColor,
                                          fontSize: size.width * 0.04,
                                          fontFamily: 'Almarai',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                            color: Theme
                                                .of(context)
                                                .primaryColorDark,
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toggle the state of the passwordVisible variable
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
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


                                ],
                              ),
                            ),
                            // Display error message for password field
                            if (errorPass != null)
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(errorPass!,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Almarai',
                                      )))
                          ],
                        )),
                    SizedBox(
                      height: size.height * 0.012,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, ForgetPass());
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' هل نسيت كلمة المرور؟',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.045,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                    ),
                    GestureDetector(
                        onTap: progress ? null : login,
                        child: progress
                            ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                            strokeWidth: 2,
                          ),
                        )
                            : Button(
                          text: 'الدخول',
                          inProgress: progress,
                        )),
                    SizedBox(height: size.height * 0.025),
                    Text(
                      ' ليس لديك حساب ؟ ',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.045,
                        color: grayColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, Register());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            arrowLeft,
                            width: size.width * 0.06,
                          ),
                          Text(
                            ' تسجيل حساب جديد ',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.045,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        progress = true;
        email = emailController.text;
        password = passController.text;
      });
      try {
        Map<String, dynamic>? response = await _api.login(email!, password!);

        print('Email: $email');
        print('Password: $password');

        if (response != null && response['status'] == 200) {
          String? token = response['data']?['token'];

          if (token != null) {
            await saveData('token', str: token);
            print('Token: $token');
          } else {
            print('Token not found in the response.');
          }

          String errorMessage = response['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: Colors.white,
            ),
          );
          navigateWithoutHistory(context, BottomBarPage());

        } else if (response != null && response['status'] == 422) {
          // Handle validation errors
          String errorMessage = response['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: Colors.white,
            ),
          );
        } else {
          // Handle other response statuses or error messages
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
