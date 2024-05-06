import 'package:e_commerce/constant/colors.dart';
import 'package:e_commerce/constant/navigator.dart';
import 'package:e_commerce/presentation/screens/login/login.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../Cubits/Auth/auth_cubit.dart';
import '../../../api/api.dart';
import '../../../models/user.dart';
import '../../../constant/images.dart';
import '../../../utilities/shared_pref.dart';
import '../otp/otp.dart';

class Register extends StatefulWidget {
  static const String routeName = '/register';
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //bool progress = false;
  bool _passwordVisible = false;

  final _api = Api();

  final _formKey = GlobalKey<FormState>();
  String? errorEmail;

  bool isRegistering = false;
  List<String> errors = [];
  String? email;
  late User user;
  TextEditingController euController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(      backgroundColor: Colors.white,

        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.22,
          right: size.width * 0.04,
          left: size.width * 0.04,
        ),
        child: Column(
          children: [
            Image.asset(logoTitle, scale: size.width * 0.008),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'تسجيل حساب جديد',
              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
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
              'حساب جديد ',
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
                  children: [          Container(
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
                            controller: euController,
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
          if (errorEmail != null)
            Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        errorEmail!,textAlign: TextAlign.left,
        style: TextStyle(color: Colors.red,                           fontFamily: 'Almarai',
        ),
      ),),

                    SizedBox(
                      height: size.height * 0.035,
                    ),
                    GestureDetector(
                      onTap: isRegistering ? null : register,
                      child: isRegistering
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 2,
                        ),
                      )
                          : Button(
                        text: 'تسجيل',
                        inProgress: isRegistering,
                      ),
                    ),

                  ],
                )),
            SizedBox(height: size.height * 0.04),
            Text(
              ' لديك حساب بالفعل ؟ ',
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
                navigateTo(context, Login());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    arrowLeft,
                    width: size.width * 0.06,
                  ),
                  Text(
                    'تسجيل الدخول ',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.045,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void register() async {

    if (_formKey.currentState!.validate() ) {
      setState(() {
        isRegistering = true;
        email = euController.text;
      });
    try {
      Map<String, dynamic>? response = await _api.register(email!);

      if (response != null && response['status'] == 200) {

        print('navigate otp');
        navigateTo(context, Otp(email: email!,name: 'register',));
        print('after navigateTo');
      } else if(response != null && response['status'] == 422){
        print( response['message'],);
        Fluttertoast.showToast(
          msg: response['errors']['email'][0],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else {
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
        isRegistering = false;
      });
    }
  }}
}
