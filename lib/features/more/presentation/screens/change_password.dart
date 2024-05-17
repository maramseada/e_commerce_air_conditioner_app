import 'package:e_commerce/core/constant/navigator.dart';
import 'package:e_commerce/features/more/presentation/components/change_password/change_password_button_bloc.dart';
import 'package:e_commerce/features/more/presentation/controllers/change_password_cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constant/colors.dart';
import '../../../screens/forget_password/foget_pass/forget_pass.dart';
import '../components/change_password/first_password_text_field.dart';
import '../components/change_password/password_text_field.dart';
import '../components/change_password/second_password_text_field.dart';

class ChangePasswordS extends StatefulWidget {
  const ChangePasswordS({super.key});

  @override
  State<ChangePasswordS> createState() => _ChangePasswordSState();
}

String? secondPassword;
String? firstPassword;
String? password;

String? errorPass;
String? errorPassFirst;
String? errorPassSecond;
bool firstPasswordVisible = false;
bool confirmPasswordVisible = false;
bool currentPasswordVisible = false;
TextEditingController currentPasswordController = TextEditingController();
TextEditingController secondPasswordController = TextEditingController();
TextEditingController firstPasswordController = TextEditingController();

class _ChangePasswordSState extends State<ChangePasswordS> {
  final _formKey = GlobalKey<FormState>();

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
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
                icon: const Icon(
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
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PasswordTextField(),
                        if (errorPass != null)
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(errorPass!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Almarai',
                                  ))),
                        GestureDetector(
                          onTap: () {
                            navigateTo(context, const ForgetPass());
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
                        const FirstPasswordTextField(),
                        if (errorPassFirst != null)
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(errorPassFirst!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Almarai',
                                  ))),
                        const SecondPasswordTextField(),
                        if (errorPassSecond != null)
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(errorPassSecond!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Almarai',
                                  ))),
                        GestureDetector(
                          onTap: () {

                            setState(() {
                              _formKey.currentState!.validate();

                            });
    BlocProvider.of<ChangePasswordCubit>(context).changePassword();
                          },
                          child: const ChangePasswordButtonBloc(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
