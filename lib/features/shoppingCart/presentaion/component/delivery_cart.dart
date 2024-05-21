import 'package:e_commerce/core/constant/font_size.dart';
import 'package:e_commerce/core/constant/navigator.dart';
import 'package:e_commerce/features/shoppingCart/presentaion/component/select_save_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/constant/images.dart';
import '../../../more/presentation/controllers/locations_cubit/locations_cubit.dart';
import '../../../more/presentation/screens/locations/add_address.dart';


class DeliveryStep extends StatefulWidget {
  const DeliveryStep({Key? key, this.formKey, required this.onNextStep, required this.onBackStep, this.isActive = false}) : super(key: key);
  final VoidCallback onNextStep;
  final VoidCallback onBackStep;
  final bool isActive;
  final formKey;

  @override
  State<DeliveryStep> createState() => _DeliveryStepState();
}

class _DeliveryStepState extends State<DeliveryStep> {
  void _nextStep() {
    widget.onNextStep();
  }
    // if (widget.formKey.currentState!.validate() ) {
    // }}

      void _backStep() {
    widget.onBackStep();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [

                  const SizedBox(
                    height: 20
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'اختر من العناوين \nالمحفوظة',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                          fontSize: getResponsiveFontSize(context, fontSize: 16),
                          color: const Color(0xff25170B),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {                    BlocProvider.of<LocationsCubit>(context).getAreas();

                        Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => const AddAddressScreen())).then((_) => setState(() {}));

                        },
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffe4eef6)),
                              child: Icon(
                                Icons.add,
                                color: kPrimaryColor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              'التوصيل إلى عنوان آخر',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.04,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                 Container(
                   height:size.height*0.3,
                       child: SelectSaveTitleWidget(),
                 ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _backStep,
                    child: Container(
                      // padding: EdgeInsets.symmetric(vertical: size.height*0.02),
                      // margin: EdgeInsets.only(bottom: size.height*0.015),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: kPrimaryColor,
                          width: 1.0,
                        ),
                      ),
                      width: size.width * 0.42,
                      height: 60,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: kPrimaryColor,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'السابق',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: size.width * 0.05,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _nextStep,
                    child: Container(
                      width: size.width * 0.42,
                      height: 60,
                      decoration: ShapeDecoration(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'التالي',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
