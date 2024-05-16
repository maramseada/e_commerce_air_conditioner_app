import 'package:e_commerce/core/constant/font_size.dart';
import 'package:e_commerce/features/more/presentation/controllers/logout_cubit/logout_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/logout_cubit/logout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/navigator.dart';
import '../../../../screens/login/login.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutCubit, LogoutState>(builder: (context, state) {
      if (state is LogoutLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else if (state is LogoutSuccess) {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: ShapeDecoration(
            color: redColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
          ),
          child: Center(
            child: Text(
              'تأكيد تسجيل الخروج',
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 18),
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: ShapeDecoration(
            color: redColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
          ),
          child: Center(
            child: Text(
              'تأكيد تسجيل الخروج',
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 18),
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    });
  }
}
