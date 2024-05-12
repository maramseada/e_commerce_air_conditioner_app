import 'package:flutter/material.dart';
import '../../../../../constant/font_size.dart';
import '../../../../../models/fav_model.dart';
import 'empty_favourites.dart';
import 'favourites_accessory.dart';
import 'favourites_product.dart';
class FavouritesBody extends StatefulWidget {
  final FavModel? data;
  const FavouritesBody({super.key, required this.data});

  @override
  State<FavouritesBody> createState() => _FavouritesBodyState();
}

class _FavouritesBodyState extends State<FavouritesBody> {
 late  bool isFavProduct ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
        onRefresh: _pullRefresh,
        child: widget.data!.products.isNotEmpty || widget.data!.accessories.isNotEmpty
            ? Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                                  child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  widget.data!.products.isNotEmpty?     Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
                      child: Text(
                        'المنتجات',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai',
                        ),
                      )):const SizedBox(),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: size.height * 0.01),
                    child: GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.58,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: widget.data!.products.length,
                      // Set the number of items in the grid
                      itemBuilder: (context, index) {
                        return FavouritesProduct(product: widget.data!.products[index],) ;
                      },
                    ),
                  ),

                    widget.data!.products.isNotEmpty?     Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: const Divider(),
                  ):SizedBox(),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
                      child: Text(
                        'الاضافات',
                        style: TextStyle(
                          fontSize: getResponsiveFontSize(context, fontSize: 22),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Almarai',
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.04, right: size.width * 0.04, top: size.height * 0.01),
                    child: GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.55,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: widget.data!.accessories.length,
                      // Set the number of items in the grid
                      itemBuilder: (context, index) {
                        return FavouriteAccessory(accessory: widget.data!.accessories[index],);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                                  ),
                                ),
              )
            : const EmptyFavourites());
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
