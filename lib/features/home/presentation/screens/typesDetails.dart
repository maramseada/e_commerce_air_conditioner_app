import 'package:e_commerce/features/BottomBar/BottomBar.dart';
import 'package:e_commerce/features/home/presentation/components/filter/empty_products_filter_categories.dart';
import 'package:e_commerce/features/home/presentation/components/filter/filtered_products_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../models/ordermodel.dart';
import '../../../../core/constant/navigator.dart';
import '../../../../widgets/floating_button_ask_price.dart';
import '../components/filter/filter_body.dart';
import 'filter.dart';

class TypesDetails extends StatefulWidget {
 final int productId;
  final String productName;
 final List<ProductsModel> products;

  const TypesDetails({super.key, required this.productId, required this.productName, required this.products});

  @override
  State<TypesDetails> createState() => _TypesDetailsState();
}
  List<ProductsModel>?  filteredData;
class _TypesDetailsState extends State<TypesDetails> {


  @override
  Widget build(BuildContext context) {
print('fffffffiiiiiiiiiiiiiiiiiiiii$filteredData');
print('wiiiiiiiiiiiiiiiiii${widget.products}');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child:Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text(
              widget.productName,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Almarai',
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigateWithoutHistory(context,  BottomBarPage());
                filteredData = null;
                id  = null;  /// Convert categoryId to string
                brandsSelected  = [];  /// No explicit conversion here, ensure it's a List<int>
                intValueBestSeller = null;  /// Convert intValueBestSeller to string
                selectedOptionRate  = null;  /// Provide default value if null
                selectedOptionPrice = null;  //
              },
            ),
            iconTheme: const IconThemeData(
              color: Colors.blue,
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  // Wait for the result from the filter screen
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    ),
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        reverse: true,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Filter(categoryId: widget.productId, productName: widget.productName,),
                        ),
                      );
                    },
                  ).then((_) => setState(() {}));
        
                },
                icon: Row(
                  children: [
                    SvgPicture.asset('assets/images/filter-edit_linear.svg', width: size.width * 0.06),
                    Text(
                      'فلترة النتائج',
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontFamily: 'Almarai',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        
          body:
 FilteredProductsBody(products: filteredData?? widget.products,),

            floatingActionButton: const AskPriceFloatingButton(),
        ),
      ),
    );
  } }
