import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/features/shoppingCart/presentaion/component/pay_step.dart';
import 'package:e_commerce/features/shoppingCart/presentaion/component/product_step.dart';
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
                              :const Color(0xffA5A5A5),
                        ),
                      ),

                    ],
                  ),
                  Text(
                    'المنتجات',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.035,
                      color: _activeStepIndex >= 0
                          ?const Color(0xff2D2525)
                          :const Color(0xff828282),
                    ),
                  ),
                  const SizedBox(
                    height:5
                  ),
                  SizedBox(
                    width: size.width*0.24,
                    child: Center(
                      child: Text('المنتجات المضافة إلى العربة',
                        textAlign: TextAlign.center,  style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.032,
                            color: _activeStepIndex >= 0
                                ?const Color(0xff2D2525)
                                :const Color(0xff878383),
                          )),
                    ),
                  ),

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
                          border: Border.all(color: const Color(0xffACACAC)),
                        ),
                        child: Icon(
                          Icons.check,
                          color: _activeStepIndex >= 1
                              ? Colors.white
                              :const Color(0xffA5A5A5),
                        ),
                      ),

                    ],
                  ),
                  Text(
                    'عنوان التوصيل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.035,
                      color: _activeStepIndex >= 1
                          ?const Color(0xff2D2525)
                          : const Color(0xff828282),
                    ),
                  ),
                  const SizedBox(
                    height :5,
                  ),
                  SizedBox(
                    width: size.width*0.24,
                    child: Text('تحديد عنوان توصيل الطلب',
                     textAlign: TextAlign.center,   style: TextStyle(
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.032,
                          color: _activeStepIndex >= 1
                              ?const Color(0xff2D2525)
                              :const Color(0xff878383),
                        )),
                  ),

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
                      border: Border.all(color: const Color(0xffACACAC)),
                    ),
                    child: Icon(
                      Icons.check,
                      color: _activeStepIndex >= 2
                          ? Colors.white
                          : const Color(0xffA5A5A5),
                    ),
                  ),
                  Text(
                    'الدفع',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w800,
                      fontSize: size.width * 0.035,
                      color: _activeStepIndex >= 2
                          ? const Color(0xff2D2525)
                          : const Color(0xff828282),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    width: size.width*0.24,
                    child: Text('الدفع وإنهاء الطلب',
                        textAlign:TextAlign.center,style: TextStyle(
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.032,
                          color: _activeStepIndex >= 2
                              ? const Color(0xff2D2525)
                              : const Color(0xff878383),
                        )),
                  ),

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
