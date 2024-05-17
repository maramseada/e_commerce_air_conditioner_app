import 'package:e_commerce/features/more/presentation/controllers/change_password_cubit/change_password_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/change_password_cubit/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../widgets/button.dart';

class ChangePasswordButtonBloc extends StatelessWidget {
  const ChangePasswordButtonBloc({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      builder: (BuildContext context, state) {
        if (state is ChangePasswordLoading) {
          return  Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                strokeWidth: 2,
              ),
            ),
          );
        } else if (state is ChangePasswordSuccess) {
          return Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.06,
              right: size.width * 0.06,
              top: size.height * 0.025,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const Button(
              text: 'حفظ كلمة المرور الجديدة',
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.06,
              right: size.width * 0.06,
              top: size.height * 0.025,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const Button(
              text: 'حفظ كلمة المرور الجديدة',
            ),
          );
        }
      },
      listener: (BuildContext context, ChangePasswordState state) {
        if (state is ChangePasswordFailure) {
          const snackBar = SnackBar(
            content: Text(
              'برجاء ادخال البيانات كاملة وبشكل صحيح',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.white,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is ChangePasswordSuccess) {
          const snackBar = SnackBar(
            content: Text(
              'تم تغيير كلمة المرور بنجاح',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.white,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
