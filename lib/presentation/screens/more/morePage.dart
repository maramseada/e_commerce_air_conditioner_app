import 'package:e_commerce/Cubits/Profile/profile_cubit.dart';
import 'package:e_commerce/presentation/screens/guideLines/guide_lines.dart';
import 'package:e_commerce/presentation/screens/login/login.dart';
import 'package:e_commerce/presentation/screens/returnPolicy/return_policy.dart';
import 'package:e_commerce/presentation/screens/sign_up/register.dart';
import 'package:e_commerce/widgets/moreButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/api.dart';
import '../../../constant/colors.dart';
import '../../../constant/navigator.dart';
import '../../../models/social_media.dart';
import '../../../utilities/shared_pref.dart';
import '../../../widgets/button.dart';
import '../about_us/aboutCompany.dart';
import '../change_password/change_password.dart';
import '../editProfile/editscreen.dart';
import '../favorites/favoritesPage.dart';
import '../locations/saved_location.dart';
import '../myOrders/myorders.dart';

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
                  navigateTo(context, MyOrdersPage());
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
                  navigateTo(context, FavoritesScreen());
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
                  navigateTo(context, editPage());
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
                  navigateTo(context, AboutCompany());
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
                  navigateTo(context, GuideLines());
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
                  navigateTo(context, ReturnPolicyScreen());
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
              FutureBuilder(
                  future: _api.SocialMedia(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data == null) {
                      return Container();
                    } else {
                      data = snapshot.data;
                      return Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'تابعنا من خلال الروابط التالية',
                          style: TextStyle(color: Color(0xFF9C9C9C), fontFamily: 'Almarai', fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  }),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height*0.02
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(data![3].url!));
                      },

                      // clipBehavior: Clip.antiAlias, // Clip content to the shape

                      child: Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: SvgPicture.asset(
                          'assets/images/Group 176435.svg',
                          width: 50,
                          height: 50,
                          // Adjust the fit as needed
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(data![2].url!));
                      },

                      // clipBehavior: Clip.antiAlias, // Clip content to the shape

                      child: Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: SvgPicture.asset(
                          'assets/images/Group 176436.svg',
                          width: 50,
                          height: 50,
                          // Adjust the fit as needed
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(data![0].url!));
                      },

                      child:Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: SvgPicture.asset(
                          'assets/images/Group 176437.svg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(data![4].url!));
                      },

                      // clipBehavior: Clip.antiAlias, // Clip content to the shape

                      child: Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: SvgPicture.asset(
                          'assets/images/Group 176438.svg',
                          width: 50,
                          height: 50,
                          // Adjust the fit as needed
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(data![1].url!));
                      },
                      child:Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: SvgPicture.asset(
                          'assets/images/Group 176439.svg',
                          width: 50,
                          height: 50,
                          // Adjust the fit as needed
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void logout() async {
    setState(() {
      delete = true;
    });
    try {
      await _api.logout();
      await removeString('token');
      navigateWithoutHistory(context, Login());
    } catch (e) {
      print('Network Error: $e');
    } finally {
      setState(() {
        delete = false;
      });
    }
  }

  Future<void> _showBottomSheet() async {
    Size size = MediaQuery.of(context).size;

    // Display your bottom sheet here

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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
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
                          onTap: delete ? null : logout,
                          child: delete
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                    strokeWidth: 2,
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: size.height * 0.08,
                                  decoration: ShapeDecoration(
                                    color: delete ? redColor : redColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
                                  ),
                                  child: Center(
                                    child: delete
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'تأكيد تسجيل الخروج',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 0.05,
                                              fontFamily: 'Almarai',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                )),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
