import 'package:e_commerce/widgets/add_to_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../api/api.dart';
import '../../../api/cart_api.dart';
import '../../../api/fav_api.dart';
import '../../../core/constant/colors.dart';
import '../../../core/constant/navigator.dart';
import '../../../models/ordermodel.dart';
import '../../detailsProduct/presentation/components/productDetails.dart';
import '../../detailsProduct/presentation/controller/fav_product_cubit.dart';
import '../../detailsProduct/presentation/controller/product/product_details_cubit.dart';
import '../request_prise/request_prise.dart';
import 'filter.dart';

class FilteredDataScreen extends StatefulWidget {
  List<ProductsModel> products;
  String productName;
  FilteredDataScreen({super.key, required this.products, required this.productName});

  @override
  State<FilteredDataScreen> createState() => _FilteredDataScreenState();
}

class _FilteredDataScreenState extends State<FilteredDataScreen> {
  bool isSelected = false;
  final Api _api = Api();

  final FavApi fav_api = FavApi();
  bool progress = false;
  List<String> errors = [];
  int? selectedIndexFav;
  bool isAddingProduct = false;
  final cartApi = CartApi();
  List<ProductsModel>? products;  Future<List<ProductsModel>> fetchData() async {
    // Call your API to fetch the updated data
    // For example:
    // final updatedData = await _api.fetchProducts();
    // return updatedData;

    // For now, let's just return the existing products list
    return widget.products;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
            textDirection: TextDirection.rtl,
            child:  FutureBuilder(
                future: Future.value(widget.products),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.data == null) {
                    return Container();
                  } else {  products = snapshot.data;
                    return RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          centerTitle: true,
                          shadowColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          backgroundColor: Colors.white,

                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          iconTheme: IconThemeData(
                            color: Colors.blue,
                          ),   title: Text(
                          widget.productName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Almarai',
                          ),
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
                                        child: Filter(productName: widget.productName,),
                                      ),
                                    );
                                  },
                                );

                                // Handle the filtered data
                                if (filteredData != null) {
                                  // Update the state with the filtered data
                                  setState(() {
                                    products = filteredData; // Assuming products is the list of products to display
                                  });
                                }
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
                                        childAspectRatio: 0.48,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: products!.length,
                                      // Set the number of items in the grid
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
                                            child: const AddToCartButton());
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )),
                        floatingActionButton: Container(
                          margin: EdgeInsets.only(right: size.width / 10),
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: size.width * 0.09),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FloatingActionButton.extended(
                              elevation: 10,
                              onPressed: () {
                                navigateTo(context, RequestPrice());
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              label: Text(
                                'طلب عرض سعر',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Almarai',
                                ),
                              ),
                              icon: const Icon(Icons.add, color: Colors.white, size: 25),
                              backgroundColor: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    );

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
  void addProduct(int index) async {
    setState(() {
      isAddingProduct = true;
    });

    try {
      print('Product ID: ${ products![index].id}');

      // Call the API with the updated values
      Map<String, dynamic>? response = await cartApi.addProduct(
        itemId:  products![index].id.toString(),quantity: '1',
    addId: '1',
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
// todo Modify Fav and unFav functions to reload data after toggling favorite status
  void Fav() async {
    setState(() {
      progress = true;
    });

    try {
      Map<String, dynamic>? response = await fav_api.favProduct(selectedIndexFav!);
      print('first_name$selectedIndexFav');

      if (response != null && response['status'] == 200) {
        // Fetch updated data after toggling favorite status
        final updatedData = await fetchData();
        // Update state with the new data
        setState(() {
          products = updatedData;
        });
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
        // Fetch updated data after toggling favorite status
        final updatedData = await fetchData();
        // Update state with the new data
        setState(() {
          products = updatedData;
        });
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
