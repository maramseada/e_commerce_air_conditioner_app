import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../api/api.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/images.dart';
import '../../../../constant/navigator.dart';
import '../../../../widgets/button.dart';
import '../../login/login.dart';

class NewPass extends StatefulWidget {
  static const String routeName = "newPass";
  String? email;
  String? otp;
  NewPass({super.key, this.email, this.otp});

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {

  bool _passwordVisible = false;
  bool _passwordVisibleSec = false;
  final _api = Api();
  TextEditingController firstPassController = TextEditingController();
  TextEditingController secondPassController = TextEditingController();
  List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  bool progress = false;
  String? secondPassword;
  String? Password;
String? errorPass;
String? errorPassSec;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  eyeUnlock,
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
                    'كلمة المرور الجديدة',
                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.06),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'قم بتعيين كلمة المرور الجديدة الخاصة ',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.045,
                      color: Color(0xff2D2525),
                    ),
                  ),
                  Text(
                    'بحسابك',
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
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [

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
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      Password = value;
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
                                    controller: firstPassController,
                                    decoration: InputDecoration(
                                      hintText: 'كلمة المرور الجديدة',
                                      hintStyle: TextStyle(
                                        color: grayColor,
                                        fontSize: size.width * 0.04,
                                        fontFamily: 'Almarai',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context).primaryColorDark,
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
                                  child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                                ),
                              ],
                            ),
                          ),
// Display error message for password field
                          if (errorPass != null)
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                    errorPass!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.red,
                                      fontFamily: 'Almarai',

                                    ))),
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
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      secondPassword = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        setState(() {
                                          errorPassSec = 'برجاء ادخال كلمة المرور';
                                        });
                                        return null;
                                      }
                                      if (value.length < 8) {
                                        setState(() {
                                          errorPassSec = 'كلمة المرور يجب أن تكون 8 رموز على الأقل';
                                        });
                                        return null;
                                      } else {
                                        setState(() {
                                          errorPassSec = null;
                                        });
                                        return null;
                                      }
                                    },
                                    obscureText: !_passwordVisibleSec,
                                    controller: secondPassController,
                                    decoration: InputDecoration(
                                      hintText: 'تأكيد كلمة المرور الجديدة',
                                      hintStyle: TextStyle(
                                        color: grayColor,
                                        fontSize: size.width * 0.04,
                                        fontFamily: 'Almarai',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisibleSec
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context).primaryColorDark,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toggle the state of the passwordVisible variable
                                          setState(() {
                                            _passwordVisibleSec = !_passwordVisibleSec;
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
                                  child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                                ),
                              ],
                            ),
                          ),
// Display error message for password field
                          if (errorPassSec != null)
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                    errorPassSec!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.red
                                  ,                          fontFamily: 'Almarai',
                                    ))),

                        ],
                      )),
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  GestureDetector(
                      onTap: resetPass,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom
                        ),
                        child: Button(
                          text: 'تأكيد',
                          inProgress: progress,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetPass() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        progress = true;
        Password = firstPassController.text;
        secondPassword = secondPassController.text;
      });

      try {
        Map<String, dynamic>? response = await _api.resertPassword(widget.email!, Password!, secondPassword!, widget.otp!);

        print('first_password$secondPassword');
        print('secondpass$Password');

        if (response != null && response['status'] == 200) {
          String? token = response['data']?['token'];

          Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          navigateWithoutHistory(context, Login());
          print('navigation complete');
        } else {
          if (response != null && response['status'] == 422) {
            SnackBar snackBar = SnackBar(
              content: Text(response['errors']['password'][0], style: TextStyle(
                  color:kPrimaryColor,
                  fontSize:16,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700

              ),),
              backgroundColor: Colors.white, // Set your desired background color here
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
