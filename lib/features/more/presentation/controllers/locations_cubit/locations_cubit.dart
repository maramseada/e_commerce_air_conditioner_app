import 'package:e_commerce/models/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/places.dart';
import '../../../data/dataSource/address_api.dart';
import '../../components/locations/delete_address/delete_address.dart';
import '../../screens/locations/edit_address.dart';
import 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  ApiAddress addressApi;
  late List<Places> areas;
  List<Places>? cities;
  List<Places>? towns;
  int? areaId;
  int? cityId;
  int? townId;
  LocationsCubit({required this.addressApi}) : super(LocationsInitial());

  void deleteAddress({required int id}) async {
    emit(LocationsLoading());

    try {
      await addressApi.deleteAddress(id.toString());
      emit(LocationsSuccess());
    } catch (e, stackTrace) {
      emit(LocationsFailure(errMessage: '$e $stackTrace'));
    }
  }

  void updateAddress({required int id, required BuildContext context}) async {
    emit(LocationsUpdateAddressLoading());
    try {
      await addressApi.updateAddress(address: Address(id: id, street: street!, buildingNum: buildingText!, landmark: landmark!, townId: townId));

      emit(LocationsUpdateAddressSuccess());
    } catch (e, stackTrace) {
      emit(LocationsUpdateAddressFailure(errMessage: '$e $stackTrace'));
    }
  }

  void getAreas() async {
    emit(LocationsAreasLoading());

    try {
      areas = await addressApi.getArea();
      emit(LocationsAreasSuccess(areas: areas));
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      emit(LocationsAreasFailure(errMessage: '$e $stackTrace'));
    }
  }

  void getCity({required int id}) async {
    emit(LocationsCitiesLoading());

    try {
      cities = await addressApi.getCity(id);
      emit(LocationsCitiesSuccess(cities: cities!));
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      emit(LocationsCitiesFailure(errMessage: '$e $stackTrace'));
    }
  }

  void getTowns({required int id}) async {
    emit(LocationsTownsLoading());

    try {
      towns = await addressApi.getTown(id);
      emit(LocationsTownsSuccess(towns: towns!));
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      emit(LocationsTownsFailure(errMessage: '$e $stackTrace'));
    }
  }

  Future<void> showBottomSheet({required BuildContext context, required int id}) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return DeleteAddress(id: id);
      },
    );
  }
}
