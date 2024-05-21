import 'package:e_commerce/core/constant/text.dart';
import 'package:e_commerce/utilities/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../../api/api.dart';
import '../../../core/constant/colors.dart';
import '../../../models/places.dart';
import '../../../models/user.dart';
import '../../../utilities/shared_pref.dart';
import '../../../widgets/button.dart';

class RequestPrice extends StatefulWidget {
  RequestPrice({super.key});

  @override
  State<RequestPrice> createState() => _RequestPriceState();
}

class _RequestPriceState extends State<RequestPrice> {
  bool progress = false;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? message;
  late Future<dynamic> _workFuture;
  int areaId = 1;

  final _formKey = GlobalKey<FormState>();

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  List<String> errors = [];

  final _api = Api();

  @override
  void initState() {
    super.initState();
    _workFuture = _api.askPriceCategory();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget buildDropdown(List<Places> work) {
      return DropdownButtonFormField<String>(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFFafafaf),
        ),
        decoration: InputDecoration(
          hintText: 'أعمال الصيانة',
          hintStyle: TextStyle(
            color: grayColor,
            fontSize: size.width * 0.04,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: const Color(0xFFF7F7F7),
          enabledBorder: AppStyles().outlineBorder,
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
          focusedErrorBorder: AppStyles().outlineBorder,
        ),
        items: work.map((works) {
          return DropdownMenuItem<String>(
            value: works.name,
            child: Text(
              works.name,
              style: TextStyle(
                color: grayColor,
                fontSize: size.width * 0.04,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          // Check if value is not null
          if (value != null) {
            setState(() {
              Places? selectedPlace = work.firstWhereOrNull((place) => place.name == value);
              if (selectedPlace != null) {
                areaId = selectedPlace.id;
                print('Selected area ID: $areaId');
                // Update _citiesFuture with the new areaId
                print('Selected area ID: $selectedPlace');
              }
            });
          }
        },
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            'طلب عرض سعر ',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w800,
              fontSize: size.width * 0.045,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'يمكنك إرسال طلب عرض سعر خاص',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.04,
                      color: grayColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextFormField(
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      firstName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء ادخال الاسم الأول ';
                      } else {
                        return null;
                      }
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
                      fillColor: paleGrayColor,
                      enabledBorder: AppStyles().outlineBorder,
                      focusedBorder: AppStyles().outlineBorder,
                      errorBorder: AppStyles().outlineBorder,
                      focusedErrorBorder: AppStyles().outlineBorder,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      lastName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء ادخال الاسم الأخير ';
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
                      fillColor: paleGrayColor,
                      enabledBorder: AppStyles().outlineBorder,
                      focusedBorder: AppStyles().outlineBorder,
                      errorBorder: AppStyles().outlineBorder,
                      focusedErrorBorder: AppStyles().outlineBorder,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        errorText:
                        AppTexts().pleaseEnterEmail;
                      }
                      if (!emailRegex.hasMatch(value)) {
                        errorText:
                        AppTexts().pleaseEnterValidEmail;
                      } else {
                        errorText:
                        null;
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'البريد الإلكتروني',
                      hintStyle: TextStyle(
                        color: grayColor,
                        fontSize: size.width * 0.04,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w600,
                      ),
                      filled: true,
                      fillColor: paleGrayColor,
                      enabledBorder: AppStyles().outlineBorder,
                      focusedBorder: AppStyles().outlineBorder,
                      errorBorder: AppStyles().outlineBorder,
                      focusedErrorBorder: AppStyles().outlineBorder,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    textAlign: TextAlign.right,
                    maxLength: 10,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    controller: phoneController,
                    validator: MultiValidator([
                      RequiredValidator(
                        errorText: 'برجاء ادخال رقم التليفون',
                      ),
                      MinLengthValidator(
                        10,
                        errorText: 'رقم التليفون يجب ان يكون 10',
                      ),
                    ]),
                    decoration: InputDecoration(
                      hintText: 'رقم الجوال',
                      hintStyle: TextStyle(
                        color: grayColor,
                        fontSize: size.width * 0.04,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w600,
                      ),
                      filled: true,
                      fillColor: paleGrayColor,
                      enabledBorder: AppStyles().outlineBorder,
                      focusedBorder: AppStyles().outlineBorder,
                      errorBorder: AppStyles().outlineBorder,
                      focusedErrorBorder: AppStyles().outlineBorder,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  FutureBuilder(
                    future: _workFuture,
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Container(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        List worktype = snapshot.data;
                        if (worktype == null) {
                          return const Center(
                            child: Text('هناك خطأ ما أعد تحميل الصفحة'),
                          );
                        } else {
                          List<Places> works = List.generate(
                            worktype.length,
                            (index) => Places.fromJson(worktype[index]),
                          );

                          return buildDropdown(works);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    textAlign: TextAlign.right,
                    onChanged: (value) {
                      message = value;
                    },
                    controller: messageController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء ادخال نص الرسالة ';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'نص الرسالة',
                      hintStyle: TextStyle(
                        color: grayColor,
                        fontSize: size.width * 0.04,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w600,
                      ),
                      filled: true,
                      fillColor: paleGrayColor,
                      enabledBorder: AppStyles().outlineBorder,
                      focusedBorder: AppStyles().outlineBorder,
                      errorBorder: AppStyles().outlineBorder,
                      focusedErrorBorder: AppStyles().outlineBorder,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                      onTap: askPrice,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Button(text: AppTexts().sendRequest, inProgress: progress),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void askPrice() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        f_name: firstName!,
        l_name: lastName!,
        email: email!,
        phone: phoneNumber!,
        password: '',
        password_confirmation: '',
        otp: '',
      );
      setState(() {
        progress = true;
        firstName = fNameController.text;
        lastName = lNameController.text;
        email = emailController.text;
        phoneNumber = phoneController.text;
        message = messageController.text;
      });

      try {
        Map<String, dynamic>? response = await _api.askPrice(areaId ?? 1, user, message ?? 'this is message to ask for price');
        print('first_name$firstName');
        print('phone$phoneNumber');
        print('lastname$lastName');
        print('first_name$areaId');
        print('phone$message');
        print('lastname$lastName');
        if (response != null && response['status'] == 200) {
          Fluttertoast.showToast(
            msg: 'تم ارسال طلب السعر',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.pop(context);
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
