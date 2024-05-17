import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../api/fav_api.dart';
import '../../../../../models/fav_model.dart';
import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavApi? favApi;

  FavModel? allProducts;

  FavouritesCubit({this.favApi}) : super(FavouritesInitial());

  void favouriteProducts() async {
    try {
      allProducts = await favApi?.favProducts();

      emit(FavouritesSuccess());
    } catch (e, stackTrace) {
      emit(FavouritesFailure(errMessage: '$e $stackTrace'));
    }
  }
}
