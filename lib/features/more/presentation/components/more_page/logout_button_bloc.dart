import 'package:e_commerce/features/more/presentation/controllers/logout_cubit/logout_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/logout_cubit/logout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/navigator.dart';
import '../../../../screens/login/login.dart';
import 'logout_button.dart';

class LogoutButtonBloc extends StatelessWidget {
  const LogoutButtonBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(builder: (context, state) {
      if (state is LogoutLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else if (state is LogoutSuccess) {

        return const LogOutButton();
      } else {
        return const LogOutButton();
      }
    }, listener: (BuildContext context, LogoutState state) {
      if (state is LogoutSuccess){
        const snackBar = SnackBar(
          content: Text(
            'تم تسجيل الخروج بنجاح',
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
        navigateWithoutHistory(context, Login());

      }else if (state is LogoutFailure){
        const snackBar = SnackBar(
          content: Text(
            'يوجد خطأ يرجى المحاولة لاحقا',
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
    },);
  }
}
