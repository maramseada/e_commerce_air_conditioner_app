import 'package:e_commerce/features/more/presentation/controllers/Favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/Favourites_cubit/favourites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constant/colors.dart';
import '../../../../core/constant/font_size.dart';
import '../../../../models/fav_model.dart';
import '../components/favourites/favourite_body_bloc.dart';
import '../components/favourites/favourites_body.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<FavouritesCubit>(context).favouriteProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              ),
            ),
            title: Text(
              'المفضلة',
              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: getResponsiveFontSize(context, fontSize: 22)),
            ),
          ),
          body: const FavouritesBodyBloc(),
        ),
      ),
    );
  }
}
