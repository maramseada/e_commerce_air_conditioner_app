
import 'package:flutter/material.dart';

import '../../../../../../../core/constant/colors.dart';
import '../../components/my_orders/currentOrders.dart';
import '../../components/my_orders/expiredOrders.dart';


class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,shadowColor: Colors.white,
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
              'طلباتي',
              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
            ),
            SizedBox(
              height: size.height * 0.012,
            ),
            Text('عرض لجميع طلباتك السابقة والحالية',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.04,
                  color: grayColor,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),

        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: _backStep,
                    child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _activeStepIndex == 0 ? Colors.transparent : Color(0x3D2D2525),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          color: _activeStepIndex == 0 ? Color(0xFFCA7009) : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'الطلبات الحالية',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.035,
                              color: _activeStepIndex == 0 ? Colors.white : Color(0xffA5A5A5),
                            ),
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: _nextStep,
                    child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: _activeStepIndex == 1 ? Colors.transparent : Color(0x3D2D2525),
                            width: 1.0,
                          ),
                          color: _activeStepIndex == 1 ? Color(0xFFCA7009) : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            ' الطلبات المنتهية',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.035,
                              color: _activeStepIndex == 1 ? Colors.white : Colors.black,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Container(
              height: size.height,
              child: _buildStep(),
            ),
          ],
        ),

        //
        // Column(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 15),
        //       child: Order(),
        //     ),
        //   ],
        // ),
      ),
    ));
  }

  Widget _buildStep() {
    switch (_activeStepIndex) {
      case 0:
        return CurrentOrders(
          onNextStep: _nextStep,
          formKey: GlobalKey<FormState>(),

        );
      case 1:
      return ExpiredOrders(
          onBackStep: _backStep,
          formKey: GlobalKey<FormState>(),

        );
      default:
        return Container(); // Handle other cases or return an empty container
    }
  }

  void _nextStep() {
    if (_activeStepIndex == 0) {
      setState(() {
        _activeStepIndex = 1;
      });
    }
  }

  void _backStep() {
    if (_activeStepIndex == 1) {
      setState(() {
        _activeStepIndex = 0;
      });
    }
  }
}
