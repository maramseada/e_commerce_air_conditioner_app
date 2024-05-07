import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/fav_product_cubit.dart';
import '../controller/product/product_details_state.dart';

class FavoriteIconBloc extends StatefulWidget {
  final int id;
  const FavoriteIconBloc({
    super.key,
    required this.id,
  });

  @override
  State<FavoriteIconBloc> createState() => _FavoriteIconBlocState();
}

class _FavoriteIconBlocState extends State<FavoriteIconBloc> {
  late bool isFavProduct;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavProductDetailsCubit, FavProductDetailsState>(
      builder: (context, state) {
        if (state is FavProductDetailsLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset('assets/images/fav.svg', width: 26), // Show loading indicator
          );
        } else if (state is FavProductDetailsSuccess) {
          isFavProduct = state.product ?? false; // Update isFavProduct with the state value
          return IconButton(
            onPressed: () {
              final cubit = BlocProvider.of<FavProductDetailsCubit>(context);
              if (isFavProduct) {
                cubit.unFavProduct(id: widget.id);
              } else {
                cubit.favProduct(id: widget.id);
              }
            },
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: isFavProduct ? SvgPicture.asset('assets/images/favicon.svg', width: 26) : SvgPicture.asset('assets/images/fav.svg', width: 26),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is FavProductDetailsSuccess) {
          isFavProduct = state.product ?? false;
        }
      },
    );
  }
}
