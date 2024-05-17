import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../screens/change_password.dart';

class FirstPasswordTextField extends StatefulWidget {
  const FirstPasswordTextField({super.key});

  @override
  State<FirstPasswordTextField> createState() => _FirstPasswordTextFieldState();
}

class _FirstPasswordTextFieldState extends State<FirstPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return     Container(
      margin: EdgeInsets.only(
        left: size.width * 0.06,
        right: size.width * 0.06,
      ),
      padding: EdgeInsets.only(
        bottom: 5,
        top: 5,
        left: size.width * 0.06,
        right: size.width * 0.06,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        color: const Color(0xFFF7F7F7),
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
    );
  }
}
