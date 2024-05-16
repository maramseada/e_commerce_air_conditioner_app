import 'package:e_commerce/core/constant/navigator.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colors.dart';
import '../../screens/my_orders_screens/orderDetails.dart';

class Order extends StatelessWidget {
  OrderModel orderItem;
   Order({Key? key, required this.orderItem});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            margin: EdgeInsets.only(top: 10, left: size.width * 0.03, right: size.width * 0.03),
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: paleGrayColor,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              'رقم الطلب',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.035),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'تاريخ ووقت الطلب',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.035),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'إجمالي الطلب',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.035),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(

                              ' #${orderItem.orderNum}',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.035),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 10),
                              child:       Text(
                               orderItem.payDate?? '',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.035),
                              ),),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              '${orderItem.grandTotal} ر.س',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.035, color: Color(0xFFCA7009)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(

                  onTap: (){
                    print(orderItem.id);

                    navigateTo(context, OrderDetails(id: orderItem.id));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'عرض تفاصيل الطلب',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Icon(
                            Icons.arrow_back_sharp,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
