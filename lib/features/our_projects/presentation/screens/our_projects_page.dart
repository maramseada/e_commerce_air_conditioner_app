import 'package:e_commerce/constant/font_size.dart';
import 'package:flutter/material.dart';

import '../components/our_projects_gridview/our_projects_page_body.dart';
class OurProjectsPage extends StatelessWidget {
 const OurProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'مشاريعنا',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w800,
                  fontSize:getResponsiveFontSize(context, fontSize: 22),
                  color: Colors.black,
                ),
              ),
              Text(
                'تعرف على مشاريعنا التي تم تنفيذها',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  fontSize: getResponsiveFontSize(context, fontSize: 16),
                  color: const Color(0xFF878383),
                ),
              ),
            ],
          ),
        ),
        body: const OurProjectsPageBody()
      ),
    );
  }
}

