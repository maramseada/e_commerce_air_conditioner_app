
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../models/accessor_model.dart';
import 'accessory_state.dart';

class AccessoryCubit extends Cubit<AccessoryState> {
  Api? api;

  List<AccessoryModel>? products;
  AccessoryCubit({this.api}) : super(AccessoryInitial());
  void getAccessory() async {
    emit(AccessoryLoading());
    try {
      products = await api?.getAccessories();
      emit(AccessorySuccess(products: products));
    } catch (e, stackTrace) {
      emit(AccessoryFailure(errMessage: '$e  $stackTrace'));
    }
  }

  void getAccessoryFav() async {
    try {
      products = await api?.getAccessories();
      emit(AccessorySuccess(products: products));
    } catch (e, stackTrace) {
      emit(AccessoryFailure(errMessage: '$e  $stackTrace'));
    }
  }


}
