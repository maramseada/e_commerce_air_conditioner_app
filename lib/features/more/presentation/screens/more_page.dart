import 'package:e_commerce/features/more/presentation/controllers/logout_cubit/logout_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/social_media_cubit/social_media_cubit.dart';
import 'package:e_commerce/features/more/presentation/screens/guide_lines.dart';
import 'package:e_commerce/features/more/presentation/screens/return_policy.dart';
import 'package:e_commerce/widgets/moreButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/navigator.dart';
import 'change_password.dart';
import 'aboutCompany.dart';
import '../components/more_page/social_media.dart';
import '../controllers/Profile/profile_cubit.dart';
import 'edit_screen.dart';
import 'favorites_page.dart';
import 'locations/saved_location.dart';
import 'my_orders_screens/myorders.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  void initState() {
    BlocProvider.of<SocialMediaCubit>(context).getSocialMedia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text(
              'المزيد',
              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.057),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, const MyOrdersPage());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'طلباتي',
                      icon: 'assets/images/my requests.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const FavoritesScreen());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'المفضلة',
                      icon: 'assets/images/fav.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<ProfileCubit>(context).getProfileData();
                    navigateTo(context, const editPage());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'تعديل بياناتي',
                      icon: 'assets/images/edit.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const ChangePasswordS());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'تغيير كلمة المرور',
                      icon: 'assets/images/password.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const SavedLocationScreen());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'العناوين المحفوظة',
                      icon: 'assets/images/location.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const AboutCompany());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'عن الشركة',
                      icon: 'assets/images/about.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const GuideLines());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'الشروط والاحكام',
                      icon: 'assets/images/terms.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const ReturnPolicyScreen());
                  },
                  child: Center(
                    child: moreButton(
                      color: moreColor,
                      text: 'سياسة الاستبدال والاسترجاع',
                      icon: 'assets/images/return.svg',
                      TextColor: kPrimaryColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<LogoutCubit>(context).showBottomSheet(context: context);
                  },
                  child: Center(
                    child: moreButton(
                      color: paleRed,
                      text: 'تسجيل الخروج',
                      icon: 'assets/images/logout.svg',
                      TextColor: redColor,
                    ),
                  ),
                ),
                const SocialMedia(),
              ],
            ),
          )),
    );
  }
}
