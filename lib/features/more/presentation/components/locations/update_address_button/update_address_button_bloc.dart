import 'package:e_commerce/features/more/presentation/components/locations/update_address_button/update_address_button.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAddressButtonBloc extends StatelessWidget {
  const UpdateAddressButtonBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsCubit, LocationsState>(
        builder: (BuildContext context, state) {
          if (state is LocationsUpdateAddressLoading){
            return const Center(child: CircularProgressIndicator(color: Colors.white,));

          }else if (state is LocationsUpdateAddressSuccess){
            Navigator.pop(context);
            return const UpdateAddressButton();
          }else {
            return const UpdateAddressButton();
          }
        });
  }
}
