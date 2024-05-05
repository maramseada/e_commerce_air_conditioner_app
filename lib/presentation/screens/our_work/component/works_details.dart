import 'package:flutter/material.dart';

import '../../../../api/works_api.dart';
import '../../../../constant/colors.dart';
import '../../../../models/works.dart';

String truncateDescription(String description, int maxWords) {
  List<String> words = description.split(' ');
  if (words.length <= maxWords) {
    return description;
  } else {
    return words.sublist(0, maxWords).join(' ') + '...';
  }
}

class WorksDetails extends StatelessWidget {
  const WorksDetails({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final _api = WorksApi();
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            'أعمال الــ $type',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w800,
              fontSize: size.width * 0.05,
              color: Colors.black,
            ),
          ),
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'تعرف على أعمال تمديدات الهواء التي نقدمها',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.04,
                      color: grayColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
          FutureBuilder<dynamic>(
            future: _api.workByType(type),
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
                // Cast the result of the future to List<dynamic>
                List<dynamic> data = (snapshot.data as List<dynamic>) ?? [];
                List<Works> works = data.map((item) => Works.fromJson(item)).toList();
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        works.length,
                            (index) => GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(bottom: size.height * 0.02),
                            margin: EdgeInsets.only(bottom: size.height * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                        works[index].description,
                                        style: TextStyle(
                                          fontFamily: 'Almarai',
                                          fontWeight: FontWeight.w400,
                                          fontSize: size.width * 0.04,
                                          color: grayColor,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.03),
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
          ),
          SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//     ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.network(
//
//                       imagePath,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       )),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Text(
//                     description,
//                     style: TextStyle(
//                       fontFamily: 'Almarai',
//                       fontWeight: FontWeight.w500,
//                       fontSize: size.width * 0.045,
//                       color: Color(0xff25170B),
//                     ),
//                   ),