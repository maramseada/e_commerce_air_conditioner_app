import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/acessory_details_cubit.dart';
import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/cart_product_cubit.dart';
import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/fav_product_cubit.dart';
import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/product_details_cubit.dart';
import 'package:e_commerce/Cubits/Profile/profile_cubit.dart';
import 'package:e_commerce/api/api.dart';
import 'package:e_commerce/presentation/BottomBar/BottomBar.dart';
import 'package:e_commerce/presentation/screens/filter/filter.dart';
import 'package:e_commerce/presentation/screens/forget_password/foget_pass/forget_pass.dart';
import 'package:e_commerce/presentation/screens/forget_password/new_pass/new_pass.dart';
import 'package:e_commerce/presentation/screens/login/login.dart';
import 'package:e_commerce/presentation/screens/result_search/result_search.dart';
import 'package:e_commerce/presentation/screens/search/search.dart';
import 'package:e_commerce/presentation/screens/sign_up/complete_data.dart';
import 'package:e_commerce/presentation/screens/sign_up/register.dart';
import 'package:e_commerce/presentation/screens/splash/splash.dart';
import 'package:e_commerce/utilities/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubits/Images/image_cubit.dart';
import 'api/cart_api.dart';
import 'api/fav_api.dart';
import 'core/utiles/simple_bloc_observer.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  bool? first_time = await getBool("first_time");
  String? token = await getString('token');
  BlocOverrides.runZoned(
    () {
      runApp(
        DevicePreview(
            enabled: true,
            builder: (context) => MyApp(
                  first_time: first_time,
                  token: token,
                ) // Wrap your app
            ),
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool? first_time;

  MyApp({super.key, required this.first_time, required this.token});

  bool openSign = true;
  String? token;
  Api api = Api();
  FavApi favApi = FavApi();
  CartApi cartApi = CartApi();

  @override
  Widget build(BuildContext context) {
    if (first_time != null && first_time == false) {
      openSign = true;
    } else {
      // First Time Open The App
      saveData("first_time", boo: false);
      openSign = false;
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileCubit(api)),
          BlocProvider(create: (context) => ProductDetailsCubit(api, favApi, cartApi)),
          BlocProvider(
              create: (context) => ImagesCubit(
                    api,
                  )),
          BlocProvider(create: (context)=> AccessoryDetailsCubit(api, favApi, cartApi)),
          BlocProvider(create: (context)=> FavProductDetailsCubit(api, favApi)),
  BlocProvider(create: (context)=> CartProductDetailsCubit(api, cartApi)),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff035B97)),
            useMaterial3: true,
          ),
          routes: {
            Register.routeName: (context) => Register(),
            ForgetPass.routeName: (context) => ForgetPass(),
            NewPass.routeName: (context) => NewPass(),
            // CompleteData.routeName: (context) => CompleteData(),
            // NewPass.routeName: (context) => NewPass(),
          },
          home: main(),
        ));
  }

  Widget main() {
    if (openSign) {
      if (token != null) {
        return BottomBarPage();
      } else {
        return SplashScreen();
      }
    } else {
      return Login();
    }
  }
}
