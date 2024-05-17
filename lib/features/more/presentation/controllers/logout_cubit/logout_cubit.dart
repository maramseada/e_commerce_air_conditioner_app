import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utilities/shared_pref.dart';
import '../../../data/dataSource/account_settings_data_source.dart';
import '../../components/more_page/logout_bottom_sheet.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  AccountSettingsApi api = AccountSettingsApi();
  LogoutCubit({required this.api}) : super(LogoutInitial());

  void logout({required BuildContext context}) async {
    try {

      await removeString('token');
      final response =       await api.logout();
      if (response != null) {
        if (response['status'] == 200) {
          emit(LogoutSuccess());
        } else {
          emit(LogoutFailure(errMessage: 'logout failed'));
        }
      } else {
        emit(LogoutFailure(errMessage: 'response is null'));
      }
    } catch (e, stackTrace) {
      emit(LogoutFailure(errMessage: '$e $stackTrace'));
    }
  }

  Future<void> showBottomSheet({required BuildContext context}) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return const LogoutBottomSheet();
      },
    );
  }
}
