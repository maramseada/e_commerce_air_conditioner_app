import 'package:e_commerce/api/projects_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/navigator.dart';
import '../../../models/projectsCategory.dart';
import 'ourProjectDetails.dart';

class ourProjectsPage extends StatefulWidget {
  ourProjectsPage({super.key});

  @override
  State<ourProjectsPage> createState() => _ourProjectsPageState();
}

class _ourProjectsPageState extends State<ourProjectsPage> {
  final _api = ProjectsApi();
  List Data = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text(
            'مشاريعنا',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w800,
              fontSize: size.width * 0.05,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'تعرف على مشاريعنا التي تم تنفيذها',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.035,
                      color: Color(0xFF878383),
                    ),
                  ),
                ),
                FutureBuilder(
                    future: _api.projectCategories(),
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
                        List<Projects> projects = snapshot.data;



                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: size.height * 0.01),
                          child: GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.88,
                            ),
                            itemCount: projects.length, // Set the number of items in the grid
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  navigateTo(context, OurProjectsScreen(id: projects[index].id.toString(), name: projects[index].name,));
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFf2f7fb),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.symmetric(
                                          horizontal: BorderSide(width: 6, color: Colors.white),
                                          vertical: BorderSide(width: 1, color: Colors.white),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xFFdbe9f3),
                                                  width: 10.0,
                                                ),
                                                borderRadius: BorderRadius.circular(100),
                                                color: Color(0xFFc6dcec)),
                                            alignment: Alignment.center,
                                            height: 110,
                                            width: 110,
                                            child:FutureBuilder<Widget>(
                                              future: _api.getImage(projects[index].image),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return Container();
                                                } else if (snapshot.hasError) {
                                                  return Text('Error: ${snapshot.error}');
                                                } else {
                                                  final imageWidget = snapshot.data;
                                                  return imageWidget != null ? Container(

                                                    child: imageWidget,
                                                  ) : SizedBox(); // Return an empty SizedBox if imageWidget is null
                                                }
                                              },
                                            ),

                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.2,
                                            child: Text(
                                              projects[index].name,
                                              style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.04, fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
