import 'package:e_commerce/constant/colors.dart';
import 'package:e_commerce/presentation/screens/shoppingCart/component/pay_step.dart';
import 'package:e_commerce/presentation/screens/shoppingCart/component/product_step.dart';
import 'package:flutter/material.dart';

import 'delivery_cart.dart';

class CartStepper extends StatefulWidget {
  const CartStepper({Key? key}) : super(key: key);

  @override
  _CartStepperState createState() => _CartStepperState();
}

class _CartStepperState extends State<CartStepper> {
  int _activeStepIndex = 0;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    children: [
                      Container(
                        height: size.height * 0.13,
                        width: size.width * 0.13,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _activeStepIndex >= 0
                              ? greenColor
                              : Colors.white,
                        ),
                        child: Icon(
                          Icons.check,
                          color: _activeStepIndex >= 0
                              ? Colors.white
                              : Color(0xffA5A5A5),
                        ),
                      ),
                      // Text(
                      //   '    ـ  ـ  ـ  ـ  ـ  ـ  ـ  ـ',
                      //   style: TextStyle(
                      //     color: _activeStepIndex >= 0
                      //         ? greenColor
                      //         : Color(0xff707070),
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    'المنتجات',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.035,
                      color: _activeStepIndex >= 0
                          ? Color(0xff2D2525)
                          : Color(0xff828282),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text('المنتجات المضافة',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.032,
                        color: _activeStepIndex >= 0
                            ? Color(0xff2D2525)
                            : Color(0xff878383),
                      )),
                  Text('إلى العربة',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.032,
                        color: _activeStepIndex >= 0
                            ? Color(0xff2D2525)
                            : Color(0xff878383),
                      )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    children: [
                      Container(
                        height: size.height * 0.13,
                        width: size.width * 0.13,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _activeStepIndex >= 1
                              ? greenColor
                              : Colors.white,
                          border: Border.all(color: Color(0xffACACAC)),
                        ),
                        child: Icon(
                          Icons.check,
                          color: _activeStepIndex >= 1
                              ? Colors.white
                              : Color(0xffA5A5A5),
                        ),
                      ),
                      // Text(
                      //   '     ـ  ـ  ـ  ـ  ـ  ـ  ـ  ـ',
                      //   style: TextStyle(
                      //     color: _activeStepIndex >= 1
                      //         ? greenColor
                      //         : Color(0xff707070),
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    'عنوان التوصيل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.035,
                      color: _activeStepIndex >= 1
                          ? Color(0xff2D2525)
                          : Color(0xff828282),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text('تحديد عنوان توصيل',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.032,
                        color: _activeStepIndex >= 1
                            ? Color(0xff2D2525)
                            : Color(0xff878383),
                      )),
                  Text('الطلب',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.032,
                        color: _activeStepIndex >= 1
                            ? Color(0xff2D2525)
                            : Color(0xff878383),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.13,
                    width: size.width * 0.13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _activeStepIndex >= 2 ? greenColor : Colors.white,
                      border: Border.all(color: Color(0xffACACAC)),
                    ),
                    child: Icon(
                      Icons.check,
                      color: _activeStepIndex >= 2
                          ? Colors.white
                          : Color(0xffA5A5A5),
                    ),
                  ),
                  Text(
                    'الدفع',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.035,
                      color: _activeStepIndex >= 2
                          ? Color(0xff2D2525)
                          : Color(0xff828282),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text('   الدفع وإنهاء',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.032,
                        color: _activeStepIndex >= 2
                            ? Color(0xff2D2525)
                            : Color(0xff878383),
                      )),
                  Text('     الطلب',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.032,
                        color: _activeStepIndex >= 2
                            ? Color(0xff2D2525)
                            : Color(0xff878383),
                      )),
                ],
              ),
            ],
          ),
          Expanded(child: _buildStep()),
        ],
      ),
    );
  }

  Widget _buildStep() {
    switch (_activeStepIndex) {
      case 0:
        return ProductStep(
            onNextStep: _nextStep,
            formKey: GlobalKey<FormState>(),

        );
      case 1:
        return DeliveryStep(
          onNextStep: _nextStep,
          onBackStep: _backStep,
          formKey: GlobalKey<FormState>(),
        );
      case 2:
        return PayStep(
          formKey: GlobalKey<FormState>(),
          onBackStep: _backStep,
        );
      default:
        return Container(); // Handle other cases or return an empty container
    }
  }

  void _nextStep() {
    if (_activeStepIndex < 2) {
      setState(() {
        _activeStepIndex++;
      });
    }
  }

  void _backStep() {
    if (_activeStepIndex > 0) {
      setState(() {
        _activeStepIndex--;
      });
    }
  }
}
