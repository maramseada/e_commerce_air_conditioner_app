import 'package:e_commerce/features/more/presentation/controllers/logout_cubit/logout_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/social_media_cubit/social_media_cubit.dart';
import 'package:e_commerce/features/more/presentation/screens/guide_lines.dart';
import 'package:e_commerce/features/screens/login/login.dart';
import 'package:e_commerce/features/more/presentation/screens/return_policy.dart';
import 'package:e_commerce/widgets/moreButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../api/api.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/navigator.dart';
import '../../../../../models/social_media.dart';
import '../../../../../utilities/shared_pref.dart';
import 'change_password.dart';
import '../components/about_us/aboutCompany.dart';
import '../components/more_page/logout_button.dart';
import '../components/more_page/social_media.dart';
import '../controllers/Favourites_cubit/favourites_cubit.dart';
import '../controllers/Profile/profile_cubit.dart';
import 'edit_screen.dart';
import 'favorites_page.dart';
import 'locations/saved_location.dart';
import 'my_orders_screens/myorders.dart';

class morePage extends StatefulWidget {
  const morePage({super.key});

  @override
  State<morePage> createState() => _morePageState();
}

class _morePageState extends State<morePage> {
  String? email;
  String? password;
  bool delete = false;
  List<String> errors = [];
  List addresss = [];
  final _api = Api();
  List<SocialMediaModel>? data;
  final _formKey = GlobalKey<FormState>();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
BlocProvider.of<SocialMediaCubit>(context).getSocialMedia();
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                  navigateTo(context, ChangePasswordS());
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
                  navigateTo(
                      context,
                      SavedLocationScreen(
                        locations: addresss,
                      ));
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
                onTap: () => _showBottomSheet(),
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
        ));
  }



  Future<void> _showBottomSheet() async {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: SizedBox(
                  height: 260,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.08, bottom: size.height * 0.01),
                        child: SvgPicture.asset(
                          'assets/images/logout.svg',
                          height: size.height * 0.05,
                        ),
                      ),
                      Text(
                        'تسجيل الخروج',
                        style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04, color: redColor),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: size.height * 0.007,
                        ),
                        width: size.width * 0.6,
                        child: Text(
                          'هل أنت متأكد من تسجيل الخروج من حسابك ؟',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.035, color: grayColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.035,
                          right: size.width * 0.04,
                          left: size.width * 0.04,
                        ),
                        child: InkWell(
                            onTap:  (){BlocProvider.of<LogoutCubit>(context).logout(context: context);
                              },
                            child: const LogoutButton()),
                      )
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
