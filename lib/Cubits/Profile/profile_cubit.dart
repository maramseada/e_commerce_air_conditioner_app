
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/api.dart';
import '../../models/profileData.dart';
import '../../features/more/presentation/components/edit_profile/delete_account_sheet.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  Api api;
  profileData? user;
  ProfileCubit(this.api) : super(ProfileInitial());



  void getProfileData()async{
    emit(ProfileLoading());
    try{
      user = await api.getDataProfile();
      emit(ProfileSuccess());
    }on Exception catch (e){
      emit(ProfileFailure(errMessage: 'error: $e'));
    }
  }
  void editProfileData({required String fName, required String lName, required String phone})async{
    emit(ProfileLoading());
    try{
      user =  await api.updateAcc(fName, lName, phone);
      emit(ProfileSuccess());
    }on Exception catch (e){
      emit(ProfileFailure(errMessage: 'error: $e'));
    }
  }
  Future<void> showBottomSheet(context) async {

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return const DeleteAccountSheet();
      },
    );
  }
}

