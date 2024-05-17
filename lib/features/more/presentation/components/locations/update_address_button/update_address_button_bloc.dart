import 'package:e_commerce/features/more/presentation/components/locations/update_address_button/update_address_button.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/colors.dart';

class UpdateAddressButtonBloc extends StatelessWidget {
  const UpdateAddressButtonBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsCubit, LocationsState>(
      builder: (BuildContext context, state) {
        if (state is LocationsUpdateAddressLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else if (state is LocationsUpdateAddressSuccess) {
          Navigator.pop(context);
          return const UpdateAddressButton();
        } else {
          return const UpdateAddressButton();
        }
      },
      listener: (BuildContext context, LocationsState state) {
        if (state is LocationsUpdateAddressFailure) {
          SnackBar snackBar = const SnackBar(
            content: Text(
              'برجاء ادخال البيانات كاملة',
              style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white, // Set your desired background color here
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is LocationsUpdateAddressSuccess) {
          SnackBar snackBar = const SnackBar(
            content: Text(
              'تم تعديل العنوان بنجاح ',
              style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white, // Set your desired background color here
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
