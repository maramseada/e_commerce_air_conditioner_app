import 'package:e_commerce/models/homeModel.dart';
import 'package:e_commerce/features/home/presentation/controllers/Home/home_cubit.dart';
import 'package:e_commerce/features/home/presentation/controllers/Home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/best_sellers/best_sellers_cubit.dart';
import 'home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel? home;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocConsumer<HomeCubit, HomeState>(builder: (BuildContext context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeSuccess) {
                final home = state.home;

                return HomeBody(
                  home:    home,
                );
              } else if (state is HomeFailure) {
                return const Text('يوجد خطأ في الأتصال في الأنترنت ');
              } else {
                return Container();
              }
            }, listener: (BuildContext context, HomeState state) {

            },)),
      ),
    );
  }
}
