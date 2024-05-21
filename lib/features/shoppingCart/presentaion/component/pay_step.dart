import 'package:e_commerce/features/shoppingCart/presentaion/component/success_order.dart';
import 'package:flutter/material.dart';

import '../../../../api/cart_api.dart';
import '../../../../core/constant/colors.dart';
import '../../../../models/cart_details_model.dart';


class PayStep extends StatefulWidget {
  const PayStep({super.key, this.formKey, required this.onBackStep,  this.isActive=false});
  final VoidCallback onBackStep;
  final bool isActive;
  final formKey;

  @override
  State<PayStep> createState() => _PayStepState();
}

class _PayStepState extends State<PayStep> {
  void _backStep() {
    widget.onBackStep();
  }
  final cartApi = CartApi();
  CartData? data;
  bool isAddingCoupon = false;
  String? coupon ;
  TextEditingController couponController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool progress = false;
  List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   return FutureBuilder(
        future:  cartApi.getCartDetails(),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasError) {
    return Center(
    child: Text('Error: ${snapshot.error}'),
    );
    } else if (snapshot.data == null) {
    return Container();
    } else {
      data = snapshot.data;
     return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width*0.02),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height*0.04,),
                    Center(
                      child: Text(
                        'لديك كوبون خصم ${data!.coupon.code} بقيمة ${data!.coupon.percent}%',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.035,
                          color: Color(0xffE60B4D),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.04,),
                  Form(
                    key: _formKey,
                    child:  TextFormField(
                      textAlign: TextAlign.right,
                      onChanged: (value) {
                        coupon = value ;
                      }, validator: (value) {
                      if (value!.isEmpty) {
                        return 'لم يتم ادخال كوبون';
                      } else {
                        return null;
                      }
                    },
                      controller:   couponController,
                      decoration: InputDecoration(
                        hintText: 'أدخل كوبون الخصم',
                        hintStyle: TextStyle(
                          color: grayColor,
                          fontSize: size.width * 0.04,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w600,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            updateCart();

                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.01,
                                horizontal: size.width * 0.015),
                            height: 15,
                            width: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondColor,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7F7F7),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFF7F7F7),
                          ),
                          borderRadius: BorderRadius.circular(38),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(38),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(38),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFF7F7F7),
                          ),
                          borderRadius: BorderRadius.circular(38),
                        ),
                      ),
                    ),
                  ),
                    SizedBox(height: size.height*0.04,),

                    Text(
                      'تفاصيل الدفع',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.04,
                        color: Color(0xff2D2525),
                      ),
                    ),
                    SizedBox(height: size.height*0.03,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'إجمالي المنتجات',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.04,
                            color: Color(0xff2D2525),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                             data!.cart.total,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.042,
                                color: Color(0xff2D2525),
                              ),
                            ),
                            Text(
                              '   ر.س',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.04,
                                color: Color(0xff2D2525),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: size.height*0.02,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'قيمة الخصم',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.04,
                            color: Color(0xff2D2525),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              data!.cart.discountValue,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.042,
                                color: Color(0xff2D2525),
                              ),
                            ),
                            Text(
                              '   ر.س',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.04,
                                color: Color(0xff2D2525),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: size.height*0.02,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'قيمة الضريبة المضافة ${data!.tax}%',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.04,
                            color: Color(0xff2D2525),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                          data!.cart.addedValue,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.042,
                                color: Color(0xff2D2525),
                              ),
                            ),
                            Text(
                              '   ر.س',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.04,
                                color: Color(0xff2D2525),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: size.height*0.03,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'إجمالي الطلب',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: size.width * 0.042,
                            fontFamily: 'Almarai',
                          ),
                        ),

                        Text(
                          '${data!.cart.grandTotal} ر.س',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                            color: Color(0xFFCA7009),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height*0.1,),

                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              // Set reverse to true to make the content align to the bottom
                              reverse: true,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context)
                                      .viewInsets
                                      .bottom,
                                ),
                                child: SuccessOrder(),
                              ),
                            );
                          },
                        );
                      },

                      child: Container(
                        width: size.width*0.42,
                        height: 60,
                        decoration: ShapeDecoration(
                          color:kPrimaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Center(
                          child: Text(
                            'الدفع والإنهاء',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width*0.05,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: size.height*0.03,),
              ],
            ),
          ),
        ),
      );

    }});
  }

  void updateCart() async {
    setState(() {
      isAddingCoupon = true;
      coupon = couponController.text;
      print(data!.cart.addressId);

    });

    if (_formKey.currentState!.validate() && coupon != null) {
      try {
        CartData? updatedCart = await cartApi.updateCartDetails(coupon!);
        if (updatedCart != null) {
          setState(() {
            data = updatedCart;
          });

          // Show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Cart updated successfully',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: Colors.white, // Set your desired background color here
            ),
          );
        } else {
          throw Exception('Error updating cart. Updated data is null.');
        }
      } catch (e, stackTrace) {
        print('Error updating cart: $e');
        print(stackTrace);
        // Handle the error gracefully
        setState(() {
          errors = ['Error updating cart. Please try again.'];
        });
      } finally {
        setState(() {
          isAddingCoupon = false;
        });
      }
    }
  }

}
