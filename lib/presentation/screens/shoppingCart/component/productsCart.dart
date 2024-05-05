import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../api/cart_api.dart';
import '../../../../models/cart_model.dart';
import '../../detailsProduct/presentation/widgets/Radio.dart';
class ProductsCart extends StatefulWidget {

  int amountProduct ;
  int maxAmount ;
  final void Function(int) onAmountChange; // Define callback function

  ProductsCart({super.key,  required this.amountProduct, required this.maxAmount, required this.onAmountChange});

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  CartApi _api = CartApi();

  bool incrementAmount = false;
  int amount = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = widget.amountProduct;
    }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'حدد الكمية المطلوبة',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.04,
            fontFamily: 'Almarai',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: size.width * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.08,
                height: 30,
                decoration: BoxDecoration(
                  color: incrementAmount ? const Color(0xFFEFF5F9) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: incrementAmount ? Colors.transparent : Color(0xB31D75B1),
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: IconButton(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        if (amount < widget.maxAmount) {
                          amount++;
                          widget.onAmountChange(amount); // Call callback function with selected value

                          print('amount $amount');
                        }
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Text(
                '$amount',
                style: TextStyle(fontSize: size.width * 0.06, fontFamily: 'Almarai', fontWeight: FontWeight.bold),
              ),
              Container(
                width: size.width * 0.08,
                height: 30,
                decoration: BoxDecoration(
                  color: incrementAmount ? Color(0xFFEFF5F9) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: incrementAmount ? Colors.transparent : Color(0xB31D75B1),
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        if (amount > 0) {
                          amount--;
                          widget.onAmountChange(amount); // Call callback function with selected value

                          print('amount $amount');
                        }
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.minus,
                      color: Colors.black,
                      size: 18,
                    ),
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