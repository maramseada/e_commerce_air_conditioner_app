import 'package:e_commerce/constant/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/works_api.dart';
import '../../../constant/colors.dart';
import '../../../models/works.dart';
import '../request_prise/request_prise.dart';
import 'component/works_details.dart';

class ourWorkPage extends StatefulWidget {
  const ourWorkPage({super.key});

  @override
  State<ourWorkPage> createState() => _ourWorkPageState();
}

class _ourWorkPageState extends State<ourWorkPage> {
  final _api = WorksApi();
  List Data = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'أعمالنا',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w800,
            fontSize: size.width * 0.05,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          children: [
            Text(
              'تعرف على أعمالنا التي نقدمها',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.04,
                color: grayColor,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
                child:FutureBuilder(
                  future: _api.workCategories(),
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
                      Map<String, dynamic> data = snapshot.data;
                      List<Works> works = [];
                      data.forEach((key, value) {
                        works.add(Works.fromJson(value));
                      });
                      // Now you have a list of Works objects
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              works.length,
                                  (index) => GestureDetector(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    WorksDetails(
                                      type: works[index].type,

                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: size.height * 0.02),
                                  margin: EdgeInsets.only(bottom: size.height * 0.03),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6F6F6),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        ),
                                        child: FutureBuilder<Widget>(
                                          future: _api.getImage(works[index].image),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Container();
                                            } else if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            } else {
                                              return snapshot.data ?? SizedBox(); // Return an empty SizedBox if data is null
                                            }
                                          },
                                        ),
                                      ),

                                      SizedBox(height: size.height * 0.03),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'أعمال الــ ${works[index].type}',
                                              style: TextStyle(
                                                fontFamily: 'Almarai',
                                                fontWeight: FontWeight.w700,
                                                fontSize: size.width * 0.04,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              _truncateDescription(works[index].description, 20), // Change 20 to your desired word count
                                              style: TextStyle(
                                                fontFamily: 'Almarai',
                                                fontWeight: FontWeight.w400,
                                                fontSize: size.width * 0.04,
                                                color: grayColor,
                                              ),
                                            ),
                                            SizedBox(height: size.height * 0.03),
                                            Center(child:

                                            GestureDetector(
                                              onTap: (){
                                                navigateTo(context, RequestPrice());

                                              },
                                              child: Container(
                                                width:  size.width * 0.58,
                                                height: size.height*0.07,
                                                decoration: ShapeDecoration(
                                                  color: kPrimaryColorDark,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
                                                ),
                                                child: Center(
                                                  child:  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 25,
                                                      ),
                                                      SizedBox(width: size.width*0.03,),
                                                      Text(
                                                        'طلب عرض سعر',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: size.width * 0.045,
                                                          fontFamily: 'Almarai',
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
            )
          ],
        ),
      ),
    );
  }String _truncateDescription(String description, int wordCount) {
    List<String> words = description.split(' ');
    if (words.length > wordCount) {
      return words.sublist(0, wordCount).join(' ') + '...'; // Join first wordCount words and add '...'
    } else {
      return description; // Return full description if it's shorter than wordCount
    }
  }
}
