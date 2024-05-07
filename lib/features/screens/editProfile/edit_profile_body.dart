import 'package:e_commerce/Cubits/Profile/profile_cubit.dart';
import 'package:e_commerce/Cubits/Profile/profile_state.dart';
import 'package:e_commerce/features/screens/editProfile/success_profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/profileData.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    profileData? profileUser;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        if (state is ProfileLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProfileSuccess) {
          profileUser = BlocProvider.of<ProfileCubit>(context).user;
          return SuccessProfileData(
            user: profileUser,
          );
        } else {
          return const Text('please try again ');
        }
      },
    );
  }
}
