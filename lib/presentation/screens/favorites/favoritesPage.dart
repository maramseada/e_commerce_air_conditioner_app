import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constant/colors.dart';
import '../../../../../constant/navigator.dart';
import '../../../../../widgets/button.dart';
import '../../../api/cart_api.dart';
import '../../../api/fav_api.dart';
import '../../../constant/images.dart';
import '../../../models/fav_model.dart';
import '../../../models/ordermodel.dart';
import '../../BottomBar/BottomBar.dart';
import '../detailsProduct/presentation/components/accessory_details.dart';
import '../detailsProduct/presentation/controller/acessory_details_cubit.dart';
import '../detailsProduct/presentation/screens/accessory_details_body.dart';
import '../detailsProduct/presentation/components/productDetails.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isSelected = false;
  final FavApi _api = FavApi();
  FavModel? data;


  bool progress = false;
  List<String> errors = [];
  int? selectedIndexFav;

  bool isAddingProduct = false;
  bool isAddingAccessory = false;
  final cartApi = CartApi();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              ),
            ),
            title: Text(
              'المفضلة',
              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
            ),
          ),
          body: FutureBuilder(
            future:  _api.favProducts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
            return Center(
            child: Text('Error: ${snapshot.error}'),
            );
            } else if (snapshot.data == null) {
            return Container();
            } else {
        data = snapshot.data;
        return RefreshIndicator(
            onRefresh: _pullRefresh,
            child: data!.products.isNotEmpty || data!.accessories.isNotEmpty
                ? Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
                            child: Text(
                              'المنتجات',
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Almarai',
                              ),
                            )),
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
                            itemCount: data!.products.length,
                            // Set the number of items in the grid
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>       ProductDetails(
                                              id: data!.products[index].id,
                                            ))).then((_) => setState(() {}));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
                                        decoration: BoxDecoration(
                                          color:   data!.products[index].quantity != 0
                                              ?  Colors.white:paleGrayColor,
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
                                                  future: _api.ImageHome(data!.products[index].mainImage),
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
                                                data!.products[index].name,
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
                                                  initialRating: data!.products[index].totalRate.toDouble(),
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
                                                  '(${data!.products[index].totalRate})',
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
                                              padding: EdgeInsets.only(top: size.height * 0.01),
                                              child: Text(
                                                getLimitedDescription(data!.products[index].description, 10),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: size.width * 0.025,
                                                  fontFamily: 'Almarai',
                                                  color: grayColor,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.only(top: 8),
                                              child: Text(
                                                '${data!.products[index].price} ر.س ',
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
                                                  data!.products[index].quantity != 0
                                                      ?     GestureDetector(
                                                    onTap:(){
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
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
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
                                                  )    : Container(
                                                    child: Text(
                                                      'المنتج غير متوفر',
                                                      style: TextStyle(
                                                        color: redColor,
                                                        fontSize: size.width * 0.043,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Almarai',
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      data!.products[index].favorite == true?
                                                      setState(() {
                                                        selectedIndexFav = data!.products[index].id;
                                                        print(selectedIndexFav);
                                                        unFav();
                                                      })  :setState(() {
                                                        selectedIndexFav = data!.products[index].id;
                                                        print(selectedIndexFav);
                                                        Fav();
                                                      });
                                                    },
                                                    child: data!.products[index].favorite == true
                                                        ? SvgPicture.asset('assets/images/favicon.svg', width: size.width * 0.063)
                                                        : SvgPicture.asset('assets/images/fav.svg', width: size.width * 0.063),
                                                  ),
                                                ],
                                              ),
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
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                          child: Divider(),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
                            child: Text(
                              'الاضافات',
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Almarai',
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.04, right: size.width * 0.04, top: size.height * 0.01),
                          child: GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: data!.accessories.length,
                            // Set the number of items in the grid
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<AccessoryDetailsCubit>(context).getAccessoryDetails(
                                      id: data!.accessories[index].id,
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>   AccessoryDetails(
                                              id: data!.accessories[index].id,
                                            ))).then((_) => setState(() {}));


                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: size.height * 0.02),
                                        decoration: BoxDecoration(
                                          color: data!.accessories[index].quantity != 0 ? Colors.white : paleGrayColor,
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
                                              height: size.height * 0.11,
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
                                                  future: _api.ImageHome(data!.accessories[index].image),
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
                                              height: size.height * 0.06,
                                              padding: EdgeInsets.only(top: size.height * 0.01),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                data!.accessories[index].name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.width * 0.035,
                                                  fontFamily: 'Almarai',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: size.height * 0.06,
                                              padding: EdgeInsets.only(top: size.height * 0.01),
                                              child: Text(
                                                getLimitedDescription(data!.accessories[index].description, 10),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: size.width * 0.025,
                                                  fontFamily: 'Almarai',
                                                  color: grayColor,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.only(top: 8),
                                              child: Text(
                                                '${data!.accessories[index].price} ر.س ',
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
                                                  data!.accessories[index].quantity != 0
                                                      ? GestureDetector(
                                                    onTap:(){
                                                      addAccessory(index);
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
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
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
                                                      : Container(
                                                    child: Text(
                                                      'المنتج غير متوفر',
                                                      style: TextStyle(
                                                        color: redColor,
                                                        fontSize: size.width * 0.043,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Almarai',
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      data!.accessories[index].favorite == true?
                                                      setState(() {
                                                        selectedIndexFav = data!.accessories[index].id;
                                                        print(selectedIndexFav);
                                                        unFavAccessory();
                                                      })  :setState(() {
                                                        selectedIndexFav = data!.accessories[index].id;
                                                        print(selectedIndexFav);
                                                        FavAccessory();
                                                      });
                                                    },
                                                    child: data!.accessories[index].favorite == true
                                                        ? SvgPicture.asset('assets/images/favicon.svg', width: size.width * 0.063)
                                                        : SvgPicture.asset('assets/images/fav.svg', width: size.width * 0.063),
                                                  ),
                                                ],
                                              ),
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
                  )),
            )
                : Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  backgroundColor: Colors.white,

                  body: SafeArea(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.16,
                            ),
                            SvgPicture.asset('assets/images/favpageicon.svg'),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              width: size.width * 0.3,
                              child: Text(
                                'لا توجد لديك منتجات بالمفضلة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.width * 0.04,
                                  color: grayColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  navigateWithoutHistory(context, BottomBarPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 20),
                                  child: Button(
                                    text: 'تصفح المنتجات',
                                  ),
                                ))
                          ],
                        ),
                      )),
                )));
            }})
        ),
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
    setState(() {
    });
  }
  void Fav() async {
    setState(() {
      progress = true;
    });

    try {
      Map<String, dynamic>? response = await _api.favProduct(selectedIndexFav!);
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
      Map<String, dynamic>? response = await _api.unFavProduct(selectedIndexFav!);
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
  void FavAccessory() async {
    setState(() {
      progress = true;
    });

    try {
      Map<String, dynamic>? response = await _api.favAccessory(selectedIndexFav!);
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

  void unFavAccessory() async {
    setState(() {
      progress = true;
    });

    try {
      Map<String, dynamic>? response = await _api.unFavAccessory(selectedIndexFav!);
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
  void addAccessory(int index) async {
    setState(() {
      isAddingAccessory = true;
    });

    try {
      print('Product ID: ${ data!.accessories[index].id}');

      // Call the API with the updated values
      Map<String, dynamic>? response = await cartApi.addAccessory(
      itemId:   data!.accessories[index].id.toString(),quantity: '1',

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
        isAddingAccessory = false;
      });
    }
  }
  void addProduct(int index) async {
    setState(() {
      isAddingProduct = true;
    });

    try {
      print('Product ID: ${ data!.products[index].id}');

      // Call the API with the updated values
      Map<String, dynamic>? response = await cartApi.addProduct(
             itemId:     data!.products[index].id.toString(), quantity: '1', addId: '1',

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
