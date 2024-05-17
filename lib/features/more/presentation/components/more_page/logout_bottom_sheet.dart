import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../controllers/logout_cubit/logout_cubit.dart';
import 'logout_button_bloc.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
          height: size.height * 0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: SizedBox(
              height: size.height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 15),
                        child: SvgPicture.asset(
                          'assets/images/logout.svg',
                          height: size.height * 0.05,
                        ),
                      ),
                      Text(
                        'تسجيل الخروج',
                        style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: getResponsiveFontSize(context, fontSize: 20), color: redColor),
                      ),
                    ],
                  ),

                  SizedBox(

                    width: size.width * 0.6,
                    child: Text(
                      'هل أنت متأكد من تسجيل الخروج من حسابك ؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Almarai', fontSize: getResponsiveFontSize(context, fontSize: 18), color: grayColor),
                    ),
                  ),
                  Container(
                   margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: InkWell(
                        onTap:  (){BlocProvider.of<LogoutCubit>(context).logout(context: context);
                        },
                        child: const LogoutButtonBloc()),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
