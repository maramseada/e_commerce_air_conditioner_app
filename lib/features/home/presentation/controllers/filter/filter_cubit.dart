import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/ordermodel.dart';
import '../../../data/dataSource/filter_data_source.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterDataSource api;
  List<ProductsModel>? response;

  FilterCubit(this.api) : super(FilterInitial());

  void getFilter({    required int id,
    required List<int> brandsSelected,
     int? intValueBestSeller,
    required String selectedOptionPrice,
    required String selectedOptionRate,}) async {
    emit(FilterLoading());
    try {

      response = await api.filter(
        categoryId: id.toString(),
        brandsId: brandsSelected,
        bestseller: intValueBestSeller.toString(),
        price: selectedOptionPrice ,
        rate: selectedOptionRate ,
      );

      emit(FilterSuccess(products: response)); // Ensure response is non-null
    } on Exception catch (e) {
      emit(FilterFailure(errMessage: 'error: $e'));
    }
  }
}
