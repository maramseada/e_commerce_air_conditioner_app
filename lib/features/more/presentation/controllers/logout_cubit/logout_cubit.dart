import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/navigator.dart';
import '../../../../../utilities/shared_pref.dart';
import '../../../../screens/login/login.dart';
import '../../../data/dataSource/account_settings_data_source.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  AccountSettingsApi api = AccountSettingsApi();
  LogoutCubit({required this.api}) : super(LogoutInitial());

  void logout({required BuildContext context}) async {
    try {
      await api.logout();
      await removeString('token');

      emit(LogoutSuccess());
      navigateWithoutHistory(context, Login());
    } catch (e, stackTrace) {
      emit(LogoutFailure(errMessage: '$e $stackTrace'));
    }
  }
}
