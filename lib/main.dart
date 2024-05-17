import 'package:e_commerce/api/api.dart';
import 'package:e_commerce/features/BottomBar/BottomBar.dart';
import 'package:e_commerce/features/more/presentation/controllers/change_password_cubit/change_password_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/logout_cubit/logout_cubit.dart';
import 'package:e_commerce/features/screens/forget_password/foget_pass/forget_pass.dart';
import 'package:e_commerce/features/screens/forget_password/new_pass/new_pass.dart';
import 'package:e_commerce/features/home/presentation/controllers/Carousel/carousel_cubit.dart';
import 'package:e_commerce/features/home/presentation/controllers/Home/home_cubit.dart';
import 'package:e_commerce/features/screens/login/login.dart';

import 'package:e_commerce/features/screens/sign_up/register.dart';
import 'package:e_commerce/utilities/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubits/Images/image_cubit.dart';
import 'api/cart_api.dart';
import 'api/fav_api.dart';
import 'core/utiles/simple_bloc_observer.dart';
import 'features/detailsProduct/presentation/controller/cart_product_cubit.dart';
import 'features/detailsProduct/presentation/controller/fav_product_cubit.dart';
import 'features/detailsProduct/presentation/controller/product/product_details_cubit.dart';
import 'features/home/presentation/controllers/Accessories/accessory_cubit.dart';
import 'features/home/presentation/controllers/accessory/acessory_details_cubit.dart';
import 'features/home/presentation/controllers/best_sellers/best_sellers_cubit.dart';
import 'features/home/presentation/controllers/fav_accessory/fav_accessory_cubit.dart';
import 'features/home/presentation/controllers/fav_products_list/fav_products_list_cubit.dart';
import 'features/more/data/dataSource/account_settings_data_source.dart';
import 'features/more/data/dataSource/address_api.dart';
import 'features/more/data/dataSource/orders_data_source.dart';
import 'features/more/data/dataSource/settings_data_source.dart';
import 'features/more/presentation/controllers/Favourites_cubit/favourites_cubit.dart';
import 'features/more/presentation/controllers/Profile/profile_cubit.dart';
import 'features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'features/more/presentation/controllers/orders_cubit/orders_cubit.dart';
import 'features/more/presentation/controllers/social_media_cubit/social_media_cubit.dart';
import 'features/our_projects/data/dataSource/projects_api.dart';
import 'features/our_projects/presentation/controllers/our_projects_cubit.dart';
import 'features/our_work/data/dataSource/works_api.dart';
import 'features/our_work/presentation/controllers/our_work_cubit.dart';
import 'features/splash/splash.dart';

void main() async {

  bool? firstTime = await getBool("firstTime");
  String? token = await getString('token');
  Bloc.observer = MyBlocObserver();

      runApp(
        DevicePreview(
            enabled: true,
            builder: (context) => MyApp(
                  firstTime: firstTime,
                  token: token,
                ) // Wrap your app
            ),
      );


}

class MyApp extends StatelessWidget {
  bool? firstTime;

  MyApp({super.key, required this.firstTime, required this.token});

  bool openSign = true;
  String? token;
  Api api = Api();
  FavApi favApi = FavApi();
  ProjectsApi projectsApi = ProjectsApi();
  WorksApi workApi = WorksApi();
  CartApi cartApi = CartApi();
  SettingsApi settingsApi = SettingsApi();
  AccountSettingsApi accountSettingsApi = AccountSettingsApi();
  OrdersApi ordersApi = OrdersApi();
  ApiAddress addressApi = ApiAddress();
  @override
  Widget build(BuildContext context) {
    if (firstTime != null && firstTime == false) {
      openSign = true;
    } else {
      // First Time Open The App
      saveData("firstTime", boo: false);
      openSign = false;
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileCubit(settingsApi)),
          BlocProvider(create: (context) => ProductDetailsCubit(api, favApi, cartApi)),
          BlocProvider(create: (context) => HomeCubit(api, favApi, cartApi)),
          BlocProvider(create: (context) => AccessoryDetailsCubit(api, favApi, cartApi)),
          BlocProvider(create: (context) => BestSellersCubit(api : api,)..getBestSellers()),
          BlocProvider(create: (context) => FavProductDetailsCubit(api:api, favApi:favApi )),
          BlocProvider(create: (context) => CartProductDetailsCubit(api, cartApi)),
          BlocProvider(create: (context) => CarouselHomeCubit(api)),
          BlocProvider(create: (context) => FavouritesCubit(favApi:favApi)),
          BlocProvider(create: (context) => FavAccessoryCubit(api:api , favApi:  favApi)),
          BlocProvider(create: (context) => AccessoryCubit(api:api)..getAccessory()),
          BlocProvider(create: (context) => FavProductDetailsListCubit(api, favApi)),
          BlocProvider(create: (context) => OurProjectsCubit(projectsApi)),
          BlocProvider(create: (context) => OurWorkCubit(workApi)),
          BlocProvider(create: (context) => SocialMediaCubit( api: settingsApi)),
          BlocProvider(create: (context) => LogoutCubit( api: accountSettingsApi)),

          BlocProvider(create: (context) => OrdersCubit(  ordersApi)),
          BlocProvider(create: (context) => LocationsCubit(   addressApi: addressApi)),
          BlocProvider(create: (context) => ChangePasswordCubit( settingsApi )),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff035B97)),
            useMaterial3: true,
          ),
          routes: {
            Register.routeName: (context) => Register(),
            ForgetPass.routeName: (context) => const ForgetPass(),
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
        return const SplashScreen();
      }
    } else {
      return Login();
    }
  }
}
