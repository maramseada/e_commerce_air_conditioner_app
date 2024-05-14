import 'package:e_commerce/core/constant/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../api/api.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../widgets/button.dart';
import '../forget_password/foget_pass/forget_pass.dart';

class ChangePasswordS extends StatefulWidget {
  const ChangePasswordS({super.key});

  @override
  State<ChangePasswordS> createState() => _ChangePasswordSState();
}

class _ChangePasswordSState extends State<ChangePasswordS> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();
  TextEditingController firstPasswordController = TextEditingController();
  String? secondPassword;
  String? firstPassword;
  String? password;
  String? errorPass;
  String? errorPassFirst;
  String? errorPassSecond;

  bool progress = false;
  bool firstPasswordVisible = false;
  bool confirmPasswordVisible = false;
  bool currentPasswordVisible = false;
  final _api = Api();
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: true, // Set this property to true

          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              ),
            ),
            title: Column(
              children: [
                Text(
                  'تغيير كلمة المرور',
                  style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                Text('يمكنك تغيير كلمة المرور الخاصة بحسابك',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.04,
                      color: grayColor,
                    ))
              ],
            ),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: size.height * 0.08,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        padding: EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.035,
                                right: size.width * 0.01,
                              ),
                              child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                            ),
                            Container(
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
                                controller: currentPasswordController,
                                obscureText: !currentPasswordVisible,
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
                                      currentPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toggle the state of the passwordVisible variable
                                      setState(() {
                                        currentPasswordVisible = !currentPasswordVisible;
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
                                ))),
                      GestureDetector(
                        onTap: (){
                          navigateTo(context, ForgetPass());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: size.height * 0.035),
                          child: Text(
                            'هل نسيت كلمة المرور ؟',
                            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.04),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        padding: EdgeInsets.only(
                          bottom: 15,
                          top: 15,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          //    crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.035,
                                right: size.width * 0.01,
                                //  bottom: 13
                              ),
                              child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.035,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/Linedivider.svg',
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  firstPassword = value;
                                },
                                controller: firstPasswordController,
                                obscureText: !firstPasswordVisible,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      errorPassFirst = 'برجاء ادخال كلمة المرور';
                                    });
                                    return null;
                                  }
                                  if (value.length < 8) {
                                    setState(() {
                                      errorPassFirst = 'كلمة المرور يجب أن تكون 8 رموز على الأقل';
                                    });
                                    return null;
                                  } else {
                                    setState(() {
                                      errorPassFirst = null;
                                    });
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'كلمة المرور الجديدة',
                                  hintStyle: TextStyle(
                                    color: grayColor,
                                    fontSize: size.width * 0.04,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      firstPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toggle the state of the passwordVisible variable
                                      setState(() {
                                        firstPasswordVisible = !firstPasswordVisible;
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

                      if (errorPassFirst != null)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(errorPassFirst!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Almarai',
                                ))),
                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          left: size.width * 0.06,
                          right: size.width * 0.06,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          //    crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.035,
                                right: size.width * 0.01,
                                //  bottom: 13
                              ),
                              child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.035,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/Linedivider.svg',
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  secondPassword = value;
                                },
                                controller: secondPasswordController,
                                obscureText: !confirmPasswordVisible,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      errorPassSecond = 'برجاء ادخال كلمة المرور';
                                    });
                                    return null;
                                  }
                                  if (value.length < 8) {
                                    setState(() {
                                      errorPassSecond = 'كلمة المرور يجب أن تكون 8 رموز على الأقل';
                                    });
                                    return null;
                                  } else {
                                    setState(() {
                                      errorPassSecond = null;
                                    });
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'تأكيد كلمة المرور الجديدة',
                                  hintStyle: TextStyle(
                                    color: grayColor,
                                    fontSize: size.width * 0.04,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toggle the state of the passwordVisible variable
                                      setState(() {
                                        confirmPasswordVisible = !confirmPasswordVisible;
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
                      if (errorPassSecond != null)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(errorPassSecond!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Almarai',
                                ))),
                      GestureDetector(
                        onTap: progress ? null : changePassowrd,
                        child: progress
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                  strokeWidth: 2,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.06,
                                  right: size.width * 0.06,
                                  top: size.height * 0.025,
                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Button(
                                  text: 'حفظ كلمة المرور الجديدة',
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }

  void changePassowrd() async {
    setState(() {
      progress = true;
      firstPassword = firstPasswordController.text;
      secondPassword = secondPasswordController.text;
      password = currentPasswordController.text;
    });
    if (_formKey.currentState!.validate()) {
      try {
        Map<String, dynamic>? response = await _api.changePassword(firstPassword!, secondPassword!, password!);

        print('firstPassword $firstPassword');
        print('secondPassword: $secondPassword');
        print('password: $password');

        if (response != null && response['status'] == 200) {
          Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pop(context);
          print('Account update success');
        } else if (response != null && response['status'] == 422) {
          Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
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
