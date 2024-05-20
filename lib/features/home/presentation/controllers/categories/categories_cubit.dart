import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../../data/dataSource/categories_data_source.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesDataSource api;
 late  List<ProductsModel> products;
  CategoriesCubit(this.api) : super(CategoriesInitial());


  void getCategories({required int id }) async {
    emit(CategoriesLoading());
    try {
      products = await api.getCategories(id);

      emit(CategoriesSuccess(products: products));
    } on Exception catch (e) {
      emit(CategoriesFailure(errMessage: 'error: $e'));
    }
  }}