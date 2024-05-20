import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../api/api.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/accessor_model.dart';
import '../../../../../widgets/add_to_cart_button.dart';
import '../../../../detailsProduct/presentation/controller/cart_product_cubit.dart';

class AccessoriesProduct extends StatefulWidget {
  final AccessoryModel product;

  const AccessoriesProduct({super.key, required this.product});

  @override
  State<AccessoriesProduct> createState() => _AccessoriesProductState();
}

class _AccessoriesProductState extends State<AccessoriesProduct> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical:8),

          decoration: BoxDecoration(
            color: widget.product.quantity != 0
                ?  Colors.white:
            paleGrayColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // Shadow color
                spreadRadius: 10, // How much the shadow should spread
                blurRadius: 10, // How soft the shadow should be
                offset: const Offset(0, 3), // Changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
            Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05), // Shadow color
                    spreadRadius: 1, // How much the shadow should spread
                    blurRadius: 10, // How soft the shadow should be
                    offset: const Offset(0, 5), // Changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://albakr-ac.com/${widget.product.image}',
                    )
                )),
          ),

              Container(
                height: size.height*0.06,
                padding: EdgeInsets.only(top: size.height * 0.01),
                alignment: Alignment.centerRight,
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.035,
                    fontFamily: 'Almarai',
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '${widget.product.price} ر.س ',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almarai',
                    color: const Color(0xFFCA7009),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: widget.product.quantity != 0
                    ? GestureDetector(
                  onTap:(){
                    BlocProvider.of<CartProductDetailsCubit>(context).addToCartAccessory(
                      id: widget.product.id.toString(),
                      amount: 1, context: context,
                    );                      },
                  child:const AddToCartButton(),
                )
                    : Text(
                  'المنتج غير متوفر',
                  style: TextStyle(
                    color: redColor,
                    fontSize: getResponsiveFontSize(context, fontSize: 20),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Almarai',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
