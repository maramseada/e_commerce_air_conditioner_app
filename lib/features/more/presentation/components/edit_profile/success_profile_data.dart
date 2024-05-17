import 'package:e_commerce/core/constant/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/profileData.dart';
import '../../../../../utilities/app_styles.dart';
import '../../../../../widgets/button.dart';
import '../../controllers/Profile/profile_cubit.dart';

class SuccessProfileData extends StatelessWidget {
  SuccessProfileData({super.key, required this.user});
  profileData? user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String fName;
    String lName;
    String phone;
    TextEditingController fNameController = TextEditingController();
    TextEditingController lNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    bool progress = false;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 42, // Adjusted the top margin to reduce height
              left: size.width * 0.035,
              right: size.width * 0.035,
            ),
            padding: EdgeInsets.only(
              top: 5,
              left: size.width * 0.04,
              right: size.width * 0.06,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38),
              color: paleGrayColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: size.width * 0.035,
                    right: size.width * 0.01,
                  ),
                  child: Text(
                    'الاسم الأول',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      color: grayColor,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04, // Adjusted font size
                    ),
                  ),
                ),
                TextFormField(
                  textAlign: TextAlign.right,
                  onChanged: (value) {
                    fName = value;
                  },
                  controller: fNameController,
                  decoration: InputDecoration(
                    hintText: user?.f_name,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor:  paleGrayColor,
                    enabledBorder: AppStyles().outlineBorder,
                    focusedBorder: AppStyles().outlineBorder,
                    errorBorder: AppStyles().outlineBorder,
                    focusedErrorBorder: AppStyles().outlineBorder,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 12,
              left: size.width * 0.035,
              right: size.width * 0.035,
            ),
            padding: EdgeInsets.only(
              top: 5,
              left: size.width * 0.04,
              right: size.width * 0.06,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38),
              color: paleGrayColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: size.width * 0.035,
                    right: size.width * 0.01,
                  ),
                  child: Text(
                    'الاسم الأخير',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      color: grayColor,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04, // Adjusted font size
                    ),
                  ),
                ),
                TextFormField(
                  textAlign: TextAlign.right,
                  onChanged: (value) {
                    lName = value;
                  },
                  controller: lNameController,
                  decoration: InputDecoration(
                    hintText: user?.l_name,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor:  paleGrayColor,
                    enabledBorder: AppStyles().outlineBorder,
                    focusedBorder: AppStyles().outlineBorder,
                    errorBorder: AppStyles().outlineBorder,
                    focusedErrorBorder: AppStyles().outlineBorder,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 12, // Adjusted the top margin to reduce height
              left: size.width * 0.035,
              right: size.width * 0.035,
            ),
            padding: EdgeInsets.only(
              top: 5,
              left: size.width * 0.04,
              right: size.width * 0.06,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38),
              color: paleGrayColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: size.width * 0.035,
                    right: size.width * 0.01,
                  ),
                  child: Text(
                    ' البريد الإلكتروني',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      color: grayColor,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04, // Adjusted font size
                    ),
                  ),
                ),
                TextFormField(
                  textAlign: TextAlign.right,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: user?.email,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor:  paleGrayColor,
                    enabledBorder: AppStyles().outlineBorder,
                    focusedBorder: AppStyles().outlineBorder,
                    errorBorder: AppStyles().outlineBorder,
                    focusedErrorBorder: AppStyles().outlineBorder,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
              bottom: 30, // Adjusted the top margin to reduce height
              left: size.width * 0.035,
              right: size.width * 0.035,
            ),
            padding: EdgeInsets.only(
              top: 5,
              left: size.width * 0.04,
              right: size.width * 0.06,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38),
              color: paleGrayColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: size.width * 0.035,
                    right: size.width * 0.01,
                  ),
                  child: Text(
                    'رقم الجوال',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      color: grayColor,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04, // Adjusted font size
                    ),
                  ),
                ),
                TextFormField(
                  // textAlign: TextAlign.right,
                  onChanged: (value) {
                    phone = value;
                    phone = phoneController.text;
                  },
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: user!.phone,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor:  paleGrayColor,
                    enabledBorder: AppStyles().outlineBorder,
                    focusedBorder: AppStyles().outlineBorder,
                    errorBorder: AppStyles().outlineBorder,
                    focusedErrorBorder: AppStyles().outlineBorder,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                BlocProvider.of<ProfileCubit>(context)
                    .editProfileData(fName: fNameController.text, lName: lNameController.text, phone: phoneController.text);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.035),
                child: Button(
                  text: 'حفظ التعديلات',
                  inProgress: progress,
                ),
              )),
          InkWell(
            onTap: () async {
              BlocProvider.of<ProfileCubit>(context).showBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.only(right: size.width * 0.065, top: 20, bottom: 20),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.045, vertical: size.height * 0.06),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: paleRed,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/images/bold.svg'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts().deleteAccount,
                        style: TextStyle(
                          color: redColor,
                          fontSize: size.width * 0.035,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: Text(
                      AppTexts().delete,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: redColor,
                            fontSize: size.width * 0.03,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ElevatedButton(onPressed: child: Text(' حذف الحساب')),
        ],
      ),
    );
  }
}
