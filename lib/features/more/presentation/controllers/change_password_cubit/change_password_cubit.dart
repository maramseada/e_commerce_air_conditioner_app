import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../data/dataSource/settings_data_source.dart';
import '../../screens/change_password.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final SettingsApi api;

  ChangePasswordCubit(this.api) : super(ChangePasswordInitial());

  void changePassword() async {
    emit(ChangePasswordLoading());
    try {
  final response = await api.changePassword(firstPassword!, secondPassword!, password!);
  if (response != null) {
    if (response['status'] == 200) {
      emit(ChangePasswordSuccess());
    } else {
      emit(ChangePasswordFailure(errMessage: 'Error: ${response['message']}'));
    }
  } else {
    emit(ChangePasswordFailure(errMessage: 'Error: Response is null'));
  }
    } catch (e) {
      emit(ChangePasswordFailure(errMessage: 'Error: $e'));
    }
  }
}