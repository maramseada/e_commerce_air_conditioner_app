import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_address_button.dart';

class AddAddressButtonBloc extends StatelessWidget {
  const AddAddressButtonBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsCubit, LocationsState>(builder: (BuildContext context, state) {

      if(state is LocationsUpdateAddressLoading){
        return Container(
            margin:const EdgeInsets.only(top: 20),child: const Center(child: CircularProgressIndicator()));
      }else if (state is LocationsUpdateAddressSuccess){
        return const AddAddressButton();
      }else{
        return const AddAddressButton();
      }
    }, listener: (BuildContext context, LocationsState state) {
      if(state is LocationsUpdateAddressSuccess){
        print('sucesssssssssssssss');
      }
    },) ;
  }
}
