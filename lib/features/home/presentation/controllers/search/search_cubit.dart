import 'package:e_commerce/features/home/presentation/controllers/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../../data/dataSource/home_data_source.dart';

class SearchCubit extends Cubit<SearchState> {
  HomeDataSource api;
 late  List<ProductsModel> products;
  SearchCubit(this.api) : super(SearchInitial());

  void getSearch({required String search}) async {
    emit(SearchLoading());
    try {
      products = (await api.getSearch(search))!;
      emit(SearchSuccess(products: products));
    } on Exception catch (e) {
      emit(SearchFailure(errMessage: 'error: $e'));
    }
  }
}
