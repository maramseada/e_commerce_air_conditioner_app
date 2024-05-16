import 'package:e_commerce/core/constant/font_size.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/colors.dart';

class DeleteAddressButton extends StatelessWidget {
  const DeleteAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsCubit, LocationsState>(builder: (context, state) {
      if (state is LocationsLoading) {
        return const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            strokeWidth: 2,
          ),
        );
      } else if (state is LocationsSuccess) {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: ShapeDecoration(
            color: redColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
          ),
          child: Center(
            child: Text(
              'تأكيد حذف العنوان',
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 22),
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
              'تأكيد حذف العنوان',
              style: TextStyle(
                color: Colors.white,
                fontSize: getResponsiveFontSize(context, fontSize: 22),
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
