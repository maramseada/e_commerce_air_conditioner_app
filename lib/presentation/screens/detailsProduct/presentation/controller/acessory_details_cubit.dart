import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api/api.dart';
import '../../../../../api/cart_api.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../models/ordermodel.dart';
import 'acessory_details_state.dart';

class AccessoryDetailsCubit extends Cubit<AccessoryDetailsState> {
  Api api;
  FavApi favApi;
  CartApi cartApi;
  AccessoryModel? product;
  int amount = 1;
  AccessoryDetailsCubit(this.api, this.favApi, this.cartApi) : super(AccessoryDetailsInitial());

  void amountIncrease() {
    if (amount < product!.quantity) {
      amount++;
      print('amount$amount');
    }
    emit(AccessoryDetailsSuccess(product: product)); // Update state with new installation option
  }

  void amountDecrease() {
    if (amount > 1) {
      amount--;
      print('amount$amount');
    }
    emit(AccessoryDetailsSuccess(product: product)); // Update state with new installation option
  }

  void getAccessoryDetails({required int id}) async {
    emit(AccessoryDetailsLoading());
    try {
      product = await api.accessoryDetails(id);
      emit(AccessoryDetailsSuccess(product: product));
    } on Exception catch (e) {
      emit(AccessoryDetailsFailure(errMessage: 'error: $e'));
    }
  }

  void favProduct({required int id}) async {
    print ('idddddddd$id');
    emit(AccessoryDetailsLoading());
    try {
      print ('idddsafdddddd$id');
      await favApi.favAccessory(id);
      product = await api.accessoryDetails(id);

      emit(AccessoryDetailsSuccess(product: product)); // Update with the latest product state
    } catch (e) {
      print ('idaezrghddddddd$id');
      emit(AccessoryDetailsFailure(errMessage: 'Error favoriting product: $e'));
    }
  }

  void unFavProduct({required int id}) async {
    print ('idddddddd$id');

    emit(AccessoryDetailsLoading());
    try {
      print ('idddsafdddddd$id');

      await favApi.unFavAccessory(id);
      product = await api.accessoryDetails(id);
      emit(AccessoryDetailsSuccess(product: product)); // Update with the latest product state
    } on Exception catch (e) {
      print ('idaezrghddddddd$id');

      emit(AccessoryDetailsFailure(errMessage: 'error: $e'));
    }
  }

  void addToCart({
    required String id,
  }) async {
    emit(AccessoryDetailsLoading());
    print('amount$amount');
    try {
      await cartApi.addAccessory(itemId: id, quantity: amount.toString());
      product = await api.accessoryDetails(int.parse(id));
      emit(AccessoryDetailsSuccess(product: product)); // Update with the latest product state
    } on Exception catch (e) {
      emit(AccessoryDetailsFailure(errMessage: 'error: $e'));
    }
  }
}
