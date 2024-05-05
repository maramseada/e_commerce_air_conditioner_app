import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce/presentation/screens/detailsProduct/presentation/controller/product_details_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Cubits/Images/image_cubit.dart';
import '../../../../api/api.dart';
import '../../../../api/cart_api.dart';
import '../../../../api/fav_api.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/font_size.dart';
import '../../../../constant/navigator.dart';
import '../../../../models/homeModel.dart';
import '../../detailsProduct/presentation/components/productDetails.dart';
import '../../detailsProduct/presentation/controller/fav_product_cubit.dart';

class BestSeller extends StatefulWidget {
  BestSeller({super.key});

  @override
  State<BestSeller> createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  bool isSelected = false;
  final Api _api = Api();
  final cartApi = CartApi();
  bool progress = false;
  List<String> errors = [];
  bool isAddingProduct = false;

  final FavApi fav_api = FavApi();
  int? selectedIndexFav;
  List<Product>? products;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          color: Colors.white,
          child: FutureBuilder(
            future: _api.Home(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data == null) {
                return Container();
              } else {
                HomeModel? home = snapshot.data;
                products = home!.products;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
                            id: products![index].id,
                          );
                          BlocProvider.of<FavProductDetailsCubit>(context).isFav(
                            id: products![index].id,
                          );

                          print('hiiiii ${products![index].id}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                        id: products![index].id,
                                      )));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                color: products![index].quantity != 0 ? Colors.white : paleGrayColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.06), // Shadow color
                                    spreadRadius: 10, // How much the shadow should spread
                                    blurRadius: 10, // How soft the shadow should be
                                    offset: Offset(0, 3), // Changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 5),
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.05), // Shadow color
                                          spreadRadius: 1, // How much the shadow should spread
                                          blurRadius: 10, // How soft the shadow should be
                                          offset: Offset(0, 5), // Changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: FutureBuilder<Widget>(
                                        future: _api.ImageHome(products![index].mainImage),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container();
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          } else {
                                            final imageWidget = snapshot.data;
                                            return imageWidget != null
                                                ? SizedBox(
                                                    child: imageWidget,
                                                  )
                                                : SizedBox(); //
                                          }
                                        }),
                                  ),
                                  Container(
                                      height: 60,
                                      padding: EdgeInsets.only(top: 10),
                                      alignment: Alignment.centerRight,
                                      child: AutoSizeText(
                                        products![index].name,
                                        textAlign: TextAlign.right,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: getResponsiveFontSize(context, fontSize: 16),
                                            fontFamily: 'Almarai'),
                                      )),
                                  SizedBox(
                                    //   width: size.width * 0.2,
                                    height: 30,
                                    child: FutureBuilder<Widget>(
                                      future: _api.ImageHome(products![index].brand.image),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Container();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else {
                                          final imageWidget = snapshot.data;
                                          return imageWidget != null
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.start, // Align the row to the end (right)
                                                  children: [
                                                    imageWidget,
                                                  ],
                                                )
                                              : const SizedBox(); //
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: AutoSizeText(
                                      getLimitedDescription(products![index].description, 10),
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: getResponsiveFontSize(context, fontSize: 12),
                                        fontFamily: 'Almarai',
                                        color: grayColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: (Text(
                                      '${products![index].price} ر.س ',
                                      style: TextStyle(
                                          fontSize: size.width * 0.04, fontWeight: FontWeight.bold, fontFamily: 'Almarai', color: Color(0xFFCA7009)),
                                    )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        products![index].quantity != 0
                                            ? GestureDetector(
                                                onTap: () {
                                                  addProduct(index);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.07), // Shadow color
                                                        spreadRadius: 1, // How much the shadow should spread
                                                        blurRadius: 1, // How soft the shadow should be
                                                        offset: const Offset(1, 1), // Changes position of shadow
                                                      ),
                                                    ],
                                                    border: Border.all(width: 1.0, color: Color(0x3D1D75B1)),
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/shopping-cart.svg',
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        'أضف للعربة',
                                                        style: TextStyle(
                                                            fontFamily: 'Almarai', fontWeight: FontWeight.w700, fontSize: 14, color: kPrimaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Text(
                                              'المنتج غير متوفر',
                                              style: TextStyle(
                                                color: redColor,
                                                fontSize: size.width * 0.043,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Almarai',
                                              ),
                                            ),
                                        GestureDetector(
                                          onTap: () {
                                            products![index].favorite == true
                                                ? setState(() {
                                                    selectedIndexFav = products![index].id;
                                                    print(selectedIndexFav);
                                                    unFav();
                                                  })
                                                : setState(() {
                                                    selectedIndexFav = products![index].id;
                                                    print(selectedIndexFav);
                                                    Fav();
                                                  });
                                          },
                                          child: products![index].favorite == true
                                              ? SvgPicture.asset('assets/images/favicon.svg', width: size.width * 0.063)
                                              : SvgPicture.asset('assets/images/fav.svg', width: size.width * 0.063),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ));
                  },
                );
              }
            },
          )),
    );
  }

  String getLimitedDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length <= wordLimit) {
      return description;
    } else {
      List<String> limitedWords = words.sublist(0, wordLimit);
      return limitedWords.join(' ');
    }
  }

  void addProduct(int index) async {
    setState(() {
      isAddingProduct = true;
    });

    try {
      print('Product ID: ${products![index].id}');

      // Call the API with the updated values
      Map<String, dynamic>? response = await cartApi.addProduct(
  itemId:        products![index].id.toString(), quantity: '1', addId: '1',
      );
      SnackBar snackBar = SnackBar(
        content: Text(
          response!['message'],
          style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white, // Set your desired background color here
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Handle the API response
      if (response != null && response['status'] == 200) {
        print('Product updated successfully');
      } else if (response != null && response['status'] == 422) {
        SnackBar snackBar = SnackBar(
          content: Text(
            response['message'],
            style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white, // Set your desired background color here
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Handle error response
        setState(() {
          if (response != null && response['message'] != null) {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
          }
        });
      }
    } catch (e, stackTrace) {
      print('Error updating product: $e');
      print(stackTrace);
      // Handle the error gracefully
      setState(() {
        errors = ['Error updating product. Please try again.'];
      });
    } finally {
      setState(() {
        isAddingProduct = false;
      });
    }
  }

  void Fav() async {
    setState(() {
      progress = true;
    });

    try {
      Map<String, dynamic>? response = await fav_api.favProduct(selectedIndexFav!);
      print('first_name$selectedIndexFav');

      if (response != null && response['status'] == 200) {
        print('navigation complete');
      } else {
        // Handle the case where response is null or response.status is null or response.status is not equal to 200
      }
    } catch (e) {
      print('Network Error: $e');
      setState(() {
        errors = ['Network error occurred. Please check your connection.'];
      });
    } finally {
      setState(() {
        progress = false;
      });
    }
  }

  void unFav() async {
    setState(() {
      progress = true;
    });

    try {
      Map<String, dynamic>? response = await fav_api.unFavProduct(selectedIndexFav!);
      print('first_name$selectedIndexFav');

      if (response != null && response['status'] == 200) {
        print('navigation complete');
      } else {
        // Handle the case where response is null or response.status is null or response.status is not equal to 200
      }
    } catch (e) {
      print('Network Error: $e');
      setState(() {
        errors = ['Network error occurred. Please check your connection.'];
      });
    } finally {
      setState(() {
        progress = false;
      });
    }
  }
}