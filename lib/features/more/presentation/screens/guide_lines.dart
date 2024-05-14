import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../api/api.dart';
import '../../../../core/constant/colors.dart';
import '../../../../models/settingsModel.dart';

class GuideLines extends StatefulWidget {
  const GuideLines({super.key});

  @override
  State<GuideLines> createState() => _GuideLinesState();
}

class _GuideLinesState extends State<GuideLines> {
  final Api _api = Api();
  List<SettingsModel>? data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
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
                icon: Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
              ),
            ),
            body: FutureBuilder(
                future: _api.privacyPolicy(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.data == null) {
                    return Container();
                  } else {
                    data = snapshot.data;
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/images/terms.svg',
                                width: size.width * 0.4,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                data![0].name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Almarai', fontSize: size.width * 0.06),
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                top: 20,
                                right: size.width * 0.05,
                                left: size.width * 0.05,
                              ),
                              child: Text(
data![0].value,                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: size.width * 0.04, fontFamily: 'Almarai', fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                right: size.width * 0.05,
                                left: size.width * 0.05,
                              ),
                              child: Text(
                                data![1].value,                                 textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }
}
