import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/widgets/add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../api/api.dart';
import '../../../api/cart_api.dart';
import '../../../api/fav_api.dart';
import '../../../constant/colors.dart';
import '../../../constant/images.dart';
import '../../../constant/navigator.dart';
import '../../../models/ordermodel.dart';
import '../../detailsProduct/presentation/components/productDetails.dart';
import '../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../detailsProduct/presentation/controller/product/product_details_cubit.dart';

class ResultSearch extends StatefulWidget {
  const ResultSearch({Key? key, required this.searchQuery}) : super(key: key);
  final String searchQuery;

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  bool isSelected = false;
  final Api _api = Api();
  bool isAddingProduct = false;
  final cartApi = CartApi();
  List<ProductsModel>? products;
  final FavApi fav_api = FavApi();
  bool progress = false;
  List<String> errors = [];
  int? selectedIndexFav;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            'نتائج البحث',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w800,
              fontSize: size.width * 0.05,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: FutureBuilder(
                      future: _api.getSearch(widget.searchQuery),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.data == null) {
                          return Container();
                        } else {
                          products = snapshot.data;
                          return Center(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Image.asset(
                                    searchGray,
                                    width: size.width * 0.08,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Text(
                                    widget.searchQuery,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.width * 0.04,
                                      color: Color(0xff25170B),
                                    ),
                                  ),
                                ]),
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
                                      childAspectRatio: 0.51,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemCount: products!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
                                              id: products![index].id,
                                            );

                                            BlocProvider.of<FavProductDetailsCubit>(context).isFav(
                                              id: products![index].id,
                                            );

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>       ProductDetails(
                                                      id: products![index].id,
                                                    ))).then((_) => setState(() {}));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
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
                                                      child: CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          imageUrl: 'https://albakr-ac.com/${products![index].image}',
                                                          errorWidget: (context, url, error) => const Icon(Icons.access_alarm))
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
                                                          itemBuilder: (context, _) => const FaIcon(
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

                                                    Container(
                                                      alignment: Alignment.centerRight,
                                                      padding: const EdgeInsets.only(top: 8),
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
                                                    const SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        products![index].quantity != 0
                                                            ? GestureDetector(   onTap:(){
                                                          addProduct(index);
                                                        },
                                                                child: const AddToCartButton()
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
                                                            products![index].favorite == true?
                                                            setState(() {
                                                              selectedIndexFav = products![index].id;
                                                              print(selectedIndexFav);
                                                              unFav();
                                                            })  :setState(() {
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
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ));
                        }
                      }))

        ),
      ),
    );
  }

  void Fav() async {
    setState(() {
      progress = true;
    });

    try {
      Map<String, dynamic>? response = await fav_api.favProduct(selectedIndexFav!);
      print('first_name$selectedIndexFav');

      if (response != null && response['status'] == 200) {

        SnackBar snackBar = SnackBar(
          content: Text(response!['message'], style: TextStyle(
              color:kPrimaryColor,
              fontSize:16,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700

          ),),
          backgroundColor: Colors.white, // Set your desired background color here
        );
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
        SnackBar snackBar = SnackBar(
          content: Text(response!['message'], style: TextStyle(
              color:kPrimaryColor,
              fontSize:16,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700

          ),),
          backgroundColor: Colors.white, // Set your desired background color here
        );

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

  Future<void> _pullRefresh() async {
    setState(() {
    });
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
}

