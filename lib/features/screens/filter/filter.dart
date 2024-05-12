import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/api.dart';
import '../../../constant/colors.dart';
import '../../../constant/images.dart';
import '../../../constant/navigator.dart';
import '../../../models/brandModel.dart';
import '../../../models/ordermodel.dart';
import '../../../widgets/button.dart';
import 'filtered_data.dart';

class Filter extends StatefulWidget {
 int? categoryId;
 String productName;
 Filter({super.key, this.categoryId, required this.productName});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<bool> _checkboxValues = List.generate(13, (index) => false);
  bool progress = false;
  final Api _api = Api();
  bool _dataLoaded = false;
List<int> brandsSelected = [];
  List<BrandModel>? brand;
  Widget? imageBrand;
  int? brandId;
  List<String> errors = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      brand = await _api.getBrands();
      setState(() {
        _dataLoaded = true;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _handleCheckboxValueChanged(int index) {
    setState(() {
      _checkboxValues[index] = !_checkboxValues[index];
      // Perform any other action related to the checkbox value change here

      if (_checkboxValues[index]) {
        // Checkbox is checked, perform action with brand ID
         brandId = brand![index].id;
         brandsSelected.add(brandId!);
         print(brandsSelected);
        String brandNme = brand![index].name;
        // Use the brand ID as needed
        print('Brand ID: $brandId');
        print('brandNme : $brandNme');
      }
    });
  }


  bool isCheckAccordingSales = false;
  String? selectedOptionPrice;
  String? selectedOptionRate;
  int? intValueBestSeller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return _dataLoaded
        ? Container(
      height: size.height * 0.9,
      width: double.infinity,
      decoration: ShapeDecoration(
       color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/filter-edit_linear.svg', width: size.width * 0.08),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Text(
                      'فلترة النتائج ',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w800,
                        fontSize: size.width * 0.045,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.03,
                ),
                Text(
                  '   فلترة حسب النوع',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
                Container(
                  height: size.height * 0.33,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 3,
                    childAspectRatio: 2.2,
                    children: List.generate(brand!.length, (index) {

                      return Row(
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              side: const BorderSide(color: Color(0xffB1B1B1)),
                              activeColor: secondColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              visualDensity: VisualDensity.compact,
                              value: _checkboxValues[index],
                              onChanged: (value) {
                                _handleCheckboxValueChanged(index);
                                print(value);
                              },
                            ),
                          ),
                          // Display the image based on the image data stored in the map
                          Container(
                            width: size.width * 0.18,
                            height: size.height * 0.22,
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: 'https://albakr-ac.com/${brand![index].image}',
                                errorWidget: (context, url, error) => const Icon(Icons.access_alarm))
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                const Divider(
                  color: Color(0xffE9E9E9),
                  endIndent: 15,
                  indent: 15,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'حسب المبيعات',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        side: BorderSide(color: Color(0xffB1B1B1)),
                        activeColor: secondColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: isCheckAccordingSales,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckAccordingSales = value!;
                            intValueBestSeller = isCheckAccordingSales ? 1 : 0;

                            print('inttttvaluuueeeeeebestseller $intValueBestSeller');
                          });
                        },
                      ),
                    ),
                    Text(
                      'المنتجات الأكثر مبيعا',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.035,
                        color: Color(0xff25170B),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Divider(
                  color: Color(0xffE9E9E9),
                  endIndent: 15,
                  indent: 15,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  ' حسب السعر',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
              Container(
                height: size.height*0.1,
                child:   Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'من الأقل إلى الأعلى سعرا',
                          style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.035,
                              color: selectedOptionPrice == '0'
                                  ? kPrimaryColor
                                  : Color(0xff25170B)),
                        ),
                        activeColor: selectedOptionPrice == '0'
                            ? kPrimaryColor
                            : Color(0xff25170B),
                        value: '0',
                        groupValue: selectedOptionPrice,
                        onChanged: (value) {
                          setState(() {
                            selectedOptionPrice = value;
                            print('selectedOptionPrice$selectedOptionPrice');

                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'من الأعلى إلى الأقل سعرا',
                          style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.035,
                              color: selectedOptionPrice == '1'
                                  ? kPrimaryColor
                                  : Color(0xff25170B)),
                        ),
                        activeColor: selectedOptionPrice == '1'
                            ? kPrimaryColor
                            : Color(0xff25170B),
                        value: '1',
                        groupValue: selectedOptionPrice,
                        onChanged: (value) {
                          setState(() {
                            selectedOptionPrice = value;
                            print('selectedOptionPrice$selectedOptionPrice');

                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Divider(
                  color: Color(0xffE9E9E9),
                  endIndent: 15,
                  indent: 15,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'حسب التقييم',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
                Container(
                  height: size.height*0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'من الأقل إلى الأعلى تقييما',
                            style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.035,
                                color: selectedOptionRate == '0'
                                    ? kPrimaryColor
                                    : Color(0xff25170B)),
                          ),
                          activeColor: selectedOptionRate == '0'
                              ? kPrimaryColor
                              : Color(0xff25170B),
                          value: '0',
                          groupValue: selectedOptionRate,
                          onChanged: (value) {
                            setState(() {
                              selectedOptionRate = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'من الأعلى إلى الأقل تقييما',
                            style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.035,
                                color: selectedOptionRate == '1'
                                    ? kPrimaryColor
                                    : Color(0xff25170B)),
                          ),
                          activeColor: selectedOptionRate == '1'
                              ? kPrimaryColor
                              : Color(0xff25170B),
                          value: '1',
                          groupValue: selectedOptionRate,
                          onChanged: (value) {
                            setState(() {
                              selectedOptionRate = value;
                              print('selectedOptionRate$selectedOptionRate');
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: size.width * 0.03, ),
                  child: GestureDetector(
                      onTap: () {
                        filterFunc();
                      },
                      child: Button(text: 'فلترة', inProgress: progress)),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    ) :  Center(
      child: Container(),
    );
  }


  void filterFunc() async {
    setState(() {
      progress = true;
    });


    try {
      List<ProductsModel>? response = await _api.filter(
        widget.categoryId.toString(), // Convert categoryId to string
        brandsSelected, // No explicit conversion here, ensure it's a List<int>
        intValueBestSeller.toString(), // Convert intValueBestSeller to string
        selectedOptionRate ?? '', // Provide default value if null
        selectedOptionPrice ?? '',  // No explicit conversion here, ensure it's a String
      );

      if (response != null) {
        // Handle the list of ProductsModel objects
        navigateTo(
            context,
            FilteredDataScreen(products:response, productName: widget.productName,

            ));

        print('navigation complete');
      } else {
        // Handle null response or other cases
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
