import 'package:e_commerce/features/more/presentation/components/locations/saved_addresses/saved_addresses_body.dart';
import 'package:e_commerce/features/more/presentation/components/locations/saved_addresses/saved_addresses_body_empty.dart';
import 'package:e_commerce/features/more/presentation/controllers/Profile/profile_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/Profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/address.dart';
import '../../../../../../models/profileData.dart';

class SavedAddressesBodyBloc extends StatelessWidget {
  const SavedAddressesBodyBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        if (state is ProfileLoading) {
          // Return a loading indicator or widget
          return const Center(child: CircularProgressIndicator()); // Example
        } else if (state is ProfileSuccess) {
          final user = BlocProvider.of<ProfileCubit>(context).user;
          if (user != null && user.addresses != null && user.addresses!.isNotEmpty) {
            final addresses = List.generate(
              user.addresses!.length,
                  (index) => Address.fromJson(user.addresses![index]),
            );
            return SavedAddressesBody(addresses: addresses);
          } else {
            return const SavedAddressesBodyEmpty();
          }
        } else {
          return const SizedBox();
        }
      }, listener: (BuildContext context, ProfileState state) {  },
    );
  }
}
