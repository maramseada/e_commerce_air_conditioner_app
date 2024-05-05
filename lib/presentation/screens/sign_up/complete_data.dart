import 'package:e_commerce/constant/images.dart';
import 'package:e_commerce/constant/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../api/api.dart';
import '../../../constant/colors.dart';
import '../../../models/user.dart';
import '../../../utilities/shared_pref.dart';
import '../../../widgets/button.dart';
import '../../BottomBar/BottomBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompleteData extends StatefulWidget {
  final String? otp;
  final String? emaill;
  CompleteData({super.key, this.otp, this.emaill});
  static const String routeName = "completeData";
  @override
  State<CompleteData> createState() => _CompleteDataState();
}

class _CompleteDataState extends State<CompleteData> {
  String? first_name;
  String? last_name;
  String? phone_number;
  String? first_password;
  String? second_password;
  bool _passwordVisible = false;
  bool _passwordVisibleSec = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController vPassController = TextEditingController();
  bool progress = false;
  List<String> errors = [];

  final _api = Api();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(      backgroundColor: Colors.white,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.08,
              right: size.width * 0.04,
              left: size.width * 0.04,
            ),
            child: Column(
              children: [
                Image.asset(
                  user,
                  width: size.width * 0.2,
                  height: size.height * 0.2,
                ),
                Text(
                  'إستكمال البيانات',
                  style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.06),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'قم بإستكمال بياناتك الشخصية لتتمكن',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.045,
                    color: Color(0xff2D2525),
                  ),
                ),
                Text(
                  ' من تسجيل حسابك',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.045,
                    color: Color(0xff2D2525),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء ادخال الأسم الأول ';
                            } else {
                              return null;
                            }
                          },
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            first_name = value;
                          },
                          controller: fNameController,
                          decoration: InputDecoration(
                            hintText: 'الاسم الأول',
                            hintStyle: TextStyle(
                              color: grayColor,
                              fontSize: size.width * 0.04,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w600,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF7F7F7),
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            last_name = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء ادخال الأسم الأخير ';
                            } else {
                              return null;
                            }
                          },
                          controller: lNameController,
                          decoration: InputDecoration(
                            hintText: 'الاسم الأخير',
                            hintStyle: TextStyle(
                              color: grayColor,
                              fontSize: size.width * 0.04,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w600,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF7F7F7),
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          textAlign: TextAlign.right,
                          maxLength: 10,
                          onChanged: (value) {
                            phone_number = value;
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                              errorText: 'برجاء ادخال رقم التليفون',
                            ),
                            MinLengthValidator(
                              10,
                              errorText: 'رقم التليفون يجب ان يكون 10',
                            ),

                            //            MatchValidator(errorText: 'كلمه السر '),
                          ]),
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: 'رقم الجوال',
                            hintStyle: TextStyle(
                              color: grayColor,
                              fontSize: size.width * 0.04,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w600,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F7F7),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFF7F7F7),
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
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
                        SizedBox(
                          height: size.height * 0.02,
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
                            //    crossAxisAlignment: CrossAxisAlignment.center,
                            children: [     Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  first_password = value;
                                },
                                validator: MultiValidator([
                                  RequiredValidator(
                                    errorText: 'برجاء ادخال كلمه السر ',
                                  ),
                                  MinLengthValidator(
                                    8,
                                    errorText: 'كلمه السر يجب ان تكون 8 رموز على الأقل',
                                  ),
                                ]),
                                controller: passController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(

                                  hintText: 'كلمة المرور الجديدة',
                                  hintStyle: TextStyle(
                                    color: grayColor,
                                    fontSize: size.width * 0.04,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w600,
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
                                child: SvgPicture.asset(
                                  'assets/images/Linedivider.svg',
                                ),
                              ),   Container(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.035,
                                  right: size.width * 0.01,
                                  //  bottom: 13
                                ),
                                child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                              ),


                            ],
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
                            //    crossAxisAlignment: CrossAxisAlignment.center,
                            children: [     Expanded(
                              child: TextFormField(

                            onChanged: (value) {
                              second_password = value;
                            },
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: 'برجاء اعادة ادخال كلمه السر ',
                              ),
                              MinLengthValidator(
                                8,
                                errorText: 'كلمه السر يجب ان تكون 8 رموز على الأقل',
                              ),
                              //            MatchValidator(errorText: 'كلمه السر '),
                            ]),
                                controller: vPassController,
                                obscureText: !_passwordVisibleSec,

                                decoration: InputDecoration(

                                  hintText: 'تأكيد كلمة المرور الجديدة',
                                  hintStyle: TextStyle(
                                    color: grayColor,
                                    fontSize: size.width * 0.04,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  prefixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisibleSec ? Icons.visibility : Icons.visibility_off,
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
                                child: SvgPicture.asset(
                                  'assets/images/Linedivider.svg',
                                ),
                              ),   Container(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.035,
                                  right: size.width * 0.01,
                                  //  bottom: 13
                                ),
                                child: SvgPicture.asset('assets/images/passdelete.svg', width: 25),
                              ),


                            ],
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        GestureDetector(
                            onTap: completeRegister,
                            child: Button(
                              text: 'تأكيد',
                              inProgress: progress,
                            )),
                      ],
                    )),
                SizedBox(
                  height: size.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void completeRegister() async {
    User user = User(
      f_name: fNameController.text,
      l_name: lNameController.text,
      phone: phoneController.text,
      password: passController.text,
      password_confirmation: vPassController.text,
      email: widget.emaill!,
      otp: widget.otp!,
    );   setState(() {
      progress = true;
      first_name = fNameController.text;
      last_name = lNameController.text;
      phone_number = phoneController.text;
      first_password = passController.text;
      second_password = vPassController.text;
    });
    if (_formKey.currentState!.validate() &&
        first_name != null &&
        last_name != null &&
        phone_number != null &&
        first_password != null &&
        second_password != null) {

      try {
        Map<String, dynamic>? response = await _api.completeRegister(user);
        print('first_name$first_name');
        print('phone$phone_number');
        print('lastname$last_name');
        print('first_password$first_password');
        print('secondpass$second_password');
        print('email${widget.emaill}');
        print('otp${widget.otp}');
        if (response != null && response['status'] == 200) {
          String? token = response?['data']?['token'];

          if (token != null) {
            await saveData('token', str: token);
            print('Token: $token');
          } else {
            // Token is null, handle accordingly
            print('Token not found in the response.');
          }

          Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          navigateWithoutHistory(context, BottomBarPage());
          print('navigation complete');
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
