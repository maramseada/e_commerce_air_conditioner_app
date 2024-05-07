import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/projects_api.dart';
import '../../../models/project.dart';

class OurProjectsScreen extends StatefulWidget {
  final String id;
  final String name ;

  OurProjectsScreen({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  _OurProjectsScreenState createState() => _OurProjectsScreenState();
}

class _OurProjectsScreenState extends State<OurProjectsScreen> {
  final _api = ProjectsApi();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w800,
            fontSize: size.width * 0.05,
            color: Colors.black,
          ),
        ),


        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder<List<Project>>(
          future: _api.projectByType(widget.id),
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
              List<Project> projects = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 5.0),
                  //   child: Text(
                  //     'المشاريع الخاصة بالمجمعات التي قمنا بتنفيذها',
                  //     style: TextStyle(
                  //       fontFamily: 'Almarai',
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: size.width * 0.04,
                  //       color: Color(0xFF878383),
                  //     ),
                  //   ),
                  // ),
                    ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: size.width * 0.1),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: FutureBuilder<Widget>(
                                future: _api.getImage(projects[index].image),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    final imageWidget = snapshot.data;
                                    return imageWidget != null
                                        ?   Container(
                                      padding: EdgeInsets.only(top: 0),
                                      child: imageWidget,
                                    )
                                        : SizedBox(); // Return an empty SizedBox if imageWidget is null
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: size.width * 0.7,
                              padding: EdgeInsets.only(right: size.width * 0.01, top: 10),
                              child: Text(
                                projects[index].title,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.04,
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.7,
                              padding: EdgeInsets.only(right: size.width * 0.01, top: 10),
                              child: Text(
                                'المدينة : ${projects[index].location} ',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.035, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: size.width * 0.7,
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: 10),
                              child: Text(
                                'نوع التكييف : ${projects[index].air_condition_type} ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )],
                ),
              );
            }
          },
        ),
      ),
    ));
  }
}

// ListView.builder(
//                 physics: ScrollPhysics(),
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 itemCount: Imgaes.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     padding: EdgeInsets.symmetric(vertical: 5),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: size.width * 0.1),
//                     width: size.width * 0.8,
//                     decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(20)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(top: 5),
//                           child: Image.asset(
//                             "${Imgaes[index]}", // Make sure to adjust the path as per your project structure
//                             width: size.width * 0.8,
//                           ),
//                         ),
//                         Container(
//                           width: size.width * 0.7,
//                           padding: EdgeInsets.only(right: size.width * 0.01, top: 10),
//                           child: Text(
//                             Name[index],
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               fontFamily: 'Almarai',
//                               fontWeight: FontWeight.bold,
//                               fontSize: size.width*0.04,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: size.width * 0.7,
//                           padding: EdgeInsets.only(right: size.width * 0.01, top: 10),
//                           child: Text(
//                             'المدينة : ${City[index]} ',
//                             textAlign: TextAlign.right,
//                             style: TextStyle(fontFamily: 'Almarai', fontSize: size.width*0.035, fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                         Container(
//                           width: size.width * 0.7,
//                           padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: 10),
//                           child: Text(
//                             'نوع التكييف : ${Type[index]} ',
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               fontSize: size.width*0.035,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: 'Almarai',
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),