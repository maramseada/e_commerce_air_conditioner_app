import 'package:e_commerce/features/our_projects/presentation/components/our_projects_listview/our_projects_details_body.dart';import 'package:flutter/material.dart';
class OurProjectsScreen extends StatefulWidget {
  final String id;
  final String name ;

const  OurProjectsScreen({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  _OurProjectsScreenState createState() => _OurProjectsScreenState();
}

class _OurProjectsScreenState extends State<OurProjectsScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
              icon: const Icon(Icons.arrow_forward),
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
        body:  const OurProjectsDetailsBody()
      ),
    ));
  }
}
