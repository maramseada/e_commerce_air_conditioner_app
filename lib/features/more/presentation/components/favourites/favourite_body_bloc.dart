import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/fav_model.dart';
import '../../controllers/Favourites_cubit/favourites_cubit.dart';
import '../../controllers/Favourites_cubit/favourites_state.dart';
import 'favourites_body.dart';

class FavouritesBodyBloc extends StatelessWidget {
  const FavouritesBodyBloc({super.key});

  @override
  Widget build(BuildContext context) {

    FavModel? data;
    return BlocBuilder<FavouritesCubit, FavouritesState>(builder: (BuildContext context, state){
      if (state is FavouritesSuccess){
        data = BlocProvider.of<FavouritesCubit>(context).allProducts;
        return FavouritesBody(data: data,);
      }else{
        return const SizedBox();
      }
    });
  }
}
