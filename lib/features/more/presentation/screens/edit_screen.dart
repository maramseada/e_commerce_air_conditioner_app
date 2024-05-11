import 'package:e_commerce/Cubits/Profile/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../api/api.dart';
import '../../../../../../constant/colors.dart';
import '../../../../../../constant/navigator.dart';
import '../../../../../../models/profileData.dart';
import '../../../../../../utilities/shared_pref.dart';
import '../../../../../../widgets/button.dart';
import '../../../screens/sign_up/register.dart';
import '../components/edit_profile/delete_account_sheet.dart';
import '../components/edit_profile/edit_profile_body.dart';

class editPage extends StatefulWidget {
  const editPage({super.key});

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
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
          title: Column(
            children: [
              Text(
                'تعديل بياناتي',
                style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
              ),
              SizedBox(
                height: size.height * 0.012,
              ),
              Text('يمكنك تعديل بياناتك الشخصية',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ))
            ],
          ),
        ),
        body: const EditProfileBody(),
      ),
    ));
  }
}
