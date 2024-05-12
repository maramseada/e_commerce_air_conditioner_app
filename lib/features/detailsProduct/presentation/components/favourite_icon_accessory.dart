
import 'package:e_commerce/features/home/presentation/controllers/fav_accessory/fav_accessory_cubit.dart';
import 'package:e_commerce/features/home/presentation/controllers/fav_accessory/fav_accessory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteIconAccessoryBloc extends StatefulWidget {
  final int id;
  const FavoriteIconAccessoryBloc({
    super.key,
    required this.id,
  });

  @override
  State<FavoriteIconAccessoryBloc> createState() => _FavoriteIconAccessoryBlocState();
}

class _FavoriteIconAccessoryBlocState extends State<FavoriteIconAccessoryBloc> {
  late bool isFavProduct;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavAccessoryCubit, FavAccessoryState>(
      builder: (context, state) {
        if (state is FavAccessoryLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset('assets/images/fav.svg', width: 26), // Show loading indicator
          );
        } else if (state is FavAccessorySuccess) {
          isFavProduct = state.product ?? false; // Update isFavProduct with the state value
          return IconButton(
            onPressed: () {
              final cubit = BlocProvider.of<FavAccessoryCubit>(context);
              if (isFavProduct) {
                cubit.unFavAccessory(id: widget.id, context: context);
              } else {
                cubit.favAccessory(id: widget.id, context: context);
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
        if (state is FavAccessorySuccess) {
          isFavProduct = state.product ?? false;
        }
      },
    );
  }
}
