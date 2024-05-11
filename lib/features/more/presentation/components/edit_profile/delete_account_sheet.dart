import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../api/api.dart';
import '../../../../../constant/colors.dart';
import '../../../../../constant/navigator.dart';
import '../../../../../utilities/shared_pref.dart';
import '../../../../screens/sign_up/register.dart';

class DeleteAccountSheet extends StatefulWidget {
  const DeleteAccountSheet({super.key});

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<String> errors = [];
  final _api = Api();
  bool delete = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
          height: size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.08, bottom: size.height*0.01),
                  child: SvgPicture.asset(
                    'assets/images/bold.svg',
                    height: size.height * 0.05,
                  ),
                ),
                Text(
                  'حذف الحساب ',
                  style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04, color: redColor),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: size.height * 0.007,
                  ),
                  width: size.width * 0.6,
                  child: Text(
                    'هل أنت متأكد من حذف حسابك نهائيا من التطبيق ؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.035, color: grayColor),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          left: size.width * 0.04,
                          right: size.width * 0.04,
                        ),
                        padding: EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                          left: size.width * 0.04,
                          right: size.width * 0.06,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          //    crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                onChanged: (value) {
                                  email = value;
                                },
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'برجاء ادخال البريد الالكتروني ';
                                  }
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'برجاء ادخال بريد الكتروني صحيح';
                                  } else {
                                    return null; // Return null if the email is valid
                                  }
                                },
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
                              child: SvgPicture.asset('assets/images/Linedivider.svg', ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.035,
                                right: size.width * 0.01,
                                //  bottom: 13
                              ),
                              child: SvgPicture.asset('assets/images/emaildelete.svg', width: 30),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          left: size.width * 0.04,
                          right: size.width * 0.04,
                        ),
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: size.width * 0.04,
                          right: size.width * 0.06,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(38),
                          color: Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          //    crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Expanded(
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                onChanged: (value) {
                                  password = value;
                                },
                                controller: passController,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'ادخل كلمة المرور';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'أدخل كلمة المرور',
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
                              child: SvgPicture.asset('assets/images/Linedivider.svg', ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: size.width * 0.035,
                                right: size.width * 0.01,
                                //  bottom: 13
                              ),
                              child: SvgPicture.asset('assets/images/passdelete.svg', width: 30),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.035,
                    right: size.width * 0.04,
                    left: size.width * 0.04,
                  ),
                  child: InkWell(
                      onTap: delete ? null : deleteAcc,
                      child: delete
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 2,
                        ),
                      )
                          : Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        decoration: ShapeDecoration(
                          color: delete ? redColor : redColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
                        ),
                        child: Center(
                          child: delete
                              ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            'تأكيد حذف الحساب',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
          )),
    );
  }
  void deleteAcc() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        delete = true;
        email = emailController.text;
        password = passController.text;
      });

      try {
        Map<String, dynamic>? response = await _api.deleteAcc(email!, password!);

        if (response != null && response['status'] == 200) {
          await removeString('token');
          //   Navigator.pop(context);
          navigateWithoutHistory(context, Register());
          print('account deletion success');
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
          delete = false;
        });
      }
    }
  }
}
