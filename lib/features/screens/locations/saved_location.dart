import 'package:e_commerce/core/constant/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../widgets/button.dart';
import '../../../api/api.dart';
import '../../../models/address.dart';
import '../../../models/profileData.dart';
import 'add_address.dart';
import 'location.dart';

class SavedLocationScreen extends StatefulWidget {
  List locations;
  SavedLocationScreen({super.key, required this.locations});

  @override
  State<SavedLocationScreen> createState() => _SavedLocationScreenState();
}

class _SavedLocationScreenState extends State<SavedLocationScreen> {
  final _api = Api();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            resizeToAvoidBottomInset: true, // Set this property to true

            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
              ),
              title: Column(
                children: [
                  Text(
                    'العناوين المحفوظة',
                    style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
                  ),
                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  Text('قائمة العناوين المحفوظة الخاصة بك',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.04,
                        color: grayColor,
                      ))
                ],
              ),
            ),
            body: FutureBuilder(
                future: _api.getDataProfile(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    profileData? user = snapshot.data;
                    if (user == null) {
                      print('Profile data is null');
                      return const Center(
                        child: Text('هناك خطأ ما أعد تحميل الصفحة'),
                      );
                    } else if (user.addresses!.length == 0) {
                      return RefreshIndicator(
                          onRefresh: _pullRefresh,
                          child: SafeArea(
                          child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.16,
                            ),
                            SvgPicture.asset('assets/images/Group 176180.svg'),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              width: size.width * 0.34,
                              child: Text(
                                'لا توجد لديك عناوين محفوظة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.width * 0.04,
                                  color: grayColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  navigateTo(context, AddAddressScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 20),
                                  child: Button(
                                    text: 'إضافة عنوان جديد',
                                  ),
                                ))
                          ],
                        ),
                      )),);
                    } else {
                      print('addresses.length${user.addresses}');
                      List<Address> addresses = List.generate(
                        user.addresses!.length,
                            (index) => Address.fromJson(user.addresses![index]),
                      );
                      return  RefreshIndicator(
                          onRefresh: _pullRefresh,
                        child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              addresses.length,
                                  (index) => locationWidget(address: addresses[index]),
                            )
                          ),
                        ),),
                      );
                    }
                  }
                })));
  }  Future<void> _pullRefresh() async {
    setState(() {

    });
  }
}
