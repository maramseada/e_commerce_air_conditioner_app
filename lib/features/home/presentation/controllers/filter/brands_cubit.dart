

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/brandModel.dart';
import '../../../../../models/ordermodel.dart';
import '../../../data/dataSource/filter_data_source.dart';
import '../../screens/filter.dart';
import 'brands_state.dart';
class BrandsCubit extends Cubit<BrandsState> {
  final FilterDataSource api;
  List<BrandModel>? brands;

  BrandsCubit(this.api) : super(BrandsInitial());void getBrands() async {
  emit(BrandsLoading());
  try {
    brands = await api.getBrands();

    emit(BrandsSuccess(brand: brands));
  } on Exception catch (e) {
    emit(BrandsFailure(errMessage: 'error: $e'));
  }
}}