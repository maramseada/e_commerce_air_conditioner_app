import 'package:e_commerce/presentation/screens/detailsProduct/presentation/components/productDetails.dart';
import 'package:e_commerce/constant/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../api/api.dart';
import '../../../../api/cart_api.dart';
import '../../../../api/fav_api.dart';
import '../../../../constant/colors.dart';

import '../../../../constant/images.dart';
import '../../../../constant/navigator.dart';
import '../../../../models/homeModel.dart';
import '../../../../models/ordermodel.dart';
import '../../../../widgets/checkbox.dart';
import '../../filter/filter.dart';
import '../../filter/filter.dart';
import '../../request_prise/request_prise.dart';
import '../widgets/floating_button_ask_price.dart';

class TypesDetails extends StatefulWidget {
 final int productId;
  final String productName;

  const TypesDetails({super.key, required this.productId, required this.productName});

  @override
  State<TypesDetails> createState() => _TypesDetailsState();
}

class _TypesDetailsState extends State<TypesDetails> {
  bool isSelected = false;
  final Api _api = Api();

  final FavApi fav_api = FavApi();
  bool progress = false;
  List<String> errors = [];
  int? selectedIndexFav;
  bool isAddingProduct = false;
  final cartApi = CartApi();
  List<ProductsModel>? products;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: FutureBuilder(
                future: _api.getCategories(widget.productId),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.data == null) {
                    return Container();
                  } else {
                 products = snapshot.data;
                    return RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          centerTitle: true,
                          shadowColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          backgroundColor: Colors.white,
                          title: Text(
                            widget.productName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Almarai',
                            ),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          iconTheme: IconThemeData(
                            color: Colors.blue,
                          ),
                          actions: [
                            IconButton(
                              onPressed: () async {
                                // Wait for the result from the filter screen
                                final filteredData = await showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
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
                                );
//todo check after update
                                // Handle the filtered data
                                // if (filteredData != null) {
                                //   // Update the state with the filtered data
                                //   setState(() {
                                //     products = filteredData; // Assuming products is the list of products to display
                                //   });
                                // }
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
                        body: Center(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: size.width * 0.04, right: size.width * 0.04, top: size.height * 0.01),
                                child: GridView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.53,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: products!.length,
                                  // Set the number of items in the grid
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              ProductDetails(
                                                id: products![index].id,
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: products![index].quantity != 0 ? Colors.white : paleGrayColor,
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.1), // Shadow color
                                                spreadRadius: 10, // How much the shadow should spread
                                                blurRadius: 10, // How soft the shadow should be
                                                offset: Offset(0, 3), // Changes position of shadow
                                              ),
                                            ],
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
                                                    future: _api.ImageHome(products![index].image),
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
                                                padding: EdgeInsets.only(top: size.height * 0.01),
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  products![index].name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: size.width * 0.04,
                                                    fontFamily: 'Almarai',
                                                  ),
                                                ),
                                              ),
                                              products![index].brand != null
                                                  ? Container(
                                                      //   width: size.width * 0.2,
                                                      height: 30,
                                                      child: FutureBuilder<Widget>(
                                                        future: _api.ImageHome(products![index].brand!.image),
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
                                                                : SizedBox(); //
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  : Container(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    itemSize: 20,
                                                    initialRating: products![index].totalRate.toDouble(),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                    itemBuilder: (context, _) => FaIcon(
                                                      FontAwesomeIcons.solidStar,
                                                      color: Color(0xFFD3A100),
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                    tapOnlyMode: false,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.03,
                                                  ),
                                                  Text(
                                                    '(${products![index].totalRate})',
                                                    style: TextStyle(
                                                      color: Color(0xFFD3A100),
                                                      fontFamily: 'Almarai',
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: size.width * 0.04,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // Container(
                                              //   padding: EdgeInsets.only(top: size.height * 0.01),
                                              //   child: Text(
                                              //     getLimitedDescription(products![index].description, 10),
                                              //     overflow: TextOverflow.fade,
                                              //     textAlign: TextAlign.right,
                                              //     style: TextStyle(
                                              //       fontSize: size.width * 0.025,
                                              //       fontFamily: 'Almarai',
                                              //       color: grayColor,
                                              //     ),
                                              //   ),
                                              // ),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  '${products![index].price} ر.س ',
                                                  style: TextStyle(
                                                    fontSize: size.width * 0.04,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Almarai',
                                                    color: Color(0xFFCA7009),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    products![index].quantity != 0
                                                        ? GestureDetector(       onTap:(){
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
                                                                    offset: Offset(1, 1), // Changes position of shadow
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
                                                                        fontFamily: 'Almarai',
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: 14,
                                                                        color: kPrimaryColor),
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
                                              ),
                                            ],
                                          ),
                                        ));
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                        floatingActionButton: const AskPriceFloatingButton(),
                      ),
                    );
                  }
                })),
      ),
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

  Future<void> _pullRefresh() async {
    setState(() {});
  }
  void addProduct(int index) async {
    setState(() {
      isAddingProduct = true;
    });

    try {
      print('Product ID: ${ products![index].id}');

      // Call the API with the updated values
      Map<String, dynamic>? response = await cartApi.addProduct(
    itemId:    products![index].id.toString(), quantity: '1', addId: '1',
      );
      SnackBar snackBar = SnackBar(
        content: Text(response!['message'], style: TextStyle(
            color:kPrimaryColor,
            fontSize:16,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700

        ),),
        backgroundColor: Colors.white, // Set your desired background color here
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Handle the API response
      if (response != null && response['status'] == 200) {
        print('Product updated successfully');


      }     else if (response != null && response['status'] == 422) {      SnackBar snackBar = SnackBar(
        content: Text(response['message'], style: TextStyle(
            color:kPrimaryColor,
            fontSize:16,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700

        ),),
        backgroundColor: Colors.white, // Set your desired background color here
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);}else {
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
