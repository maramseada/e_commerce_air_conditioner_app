import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/home/presentation/controllers/filter/filter_cubit.dart';
import 'package:e_commerce/features/home/presentation/screens/typesDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/brandModel.dart';
import '../../screens/filter.dart';
import 'filter_body_bloc.dart';

class FilterBody extends StatefulWidget {
  final List<BrandModel>? brand;

  const FilterBody({super.key, required this.brand});

  @override
  State<FilterBody> createState() => _FilterBodyState();
}
bool isCheckAccordingSales = false;
String? selectedOptionPrice;
String? selectedOptionRate;
int? intValueBestSeller;
List<int> brandsSelected = [];
List<bool> checkboxValues = List.generate(13, (index) => false);
int? brandId;
class _FilterBodyState extends State<FilterBody> {
  void _handleCheckboxValueChanged(int index) {
    setState(() {
      checkboxValues[index] = !checkboxValues[index];
      // Perform any other action related to the checkbox value change here

      if (checkboxValues[index]) {
        // Checkbox is checked, perform action with brand ID
        brandId = widget.brand![index].id;
        brandsSelected.add(brandId!);
        String brandNme = widget.brand![index].name;

        debugPrint('Brand ID: $brandId');
        debugPrint('brandNme : $brandNme');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.9,
      width: double.infinity,
      decoration: const ShapeDecoration(
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
                    children: List.generate(widget.brand!.length, (index) {
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
                              value: checkboxValues[index],
                              onChanged: (value) {
                                _handleCheckboxValueChanged(index);
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
                                  imageUrl: 'https://albakr-ac.com/${widget.brand![index].image}',
                                  errorWidget: (context, url, error) => const Icon(Icons.access_alarm))),
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
                        side: const BorderSide(color: Color(0xffB1B1B1)),
                        activeColor: secondColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: isCheckAccordingSales,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckAccordingSales = value!;
                            intValueBestSeller = isCheckAccordingSales ? 1 : 0;

                            debugPrint('inttttvaluuueeeeeebestseller $intValueBestSeller');
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
                        color: const Color(0xff25170B),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
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
                  ' حسب السعر',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    fontSize: size.width * 0.04,
                    color: grayColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  child: Column(
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
                                color: selectedOptionPrice == '0' ? kPrimaryColor : const Color(0xff25170B)),
                          ),
                          activeColor: selectedOptionPrice == '0' ? kPrimaryColor : const Color(0xff25170B),
                          value: '0',
                          groupValue: selectedOptionPrice,
                          onChanged: (value) {
                            setState(() {
                              selectedOptionPrice = value;
                              debugPrint('selectedOptionPrice$selectedOptionPrice');
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
                                color: selectedOptionPrice == '1' ? kPrimaryColor : const Color(0xff25170B)),
                          ),
                          activeColor: selectedOptionPrice == '1' ? kPrimaryColor : const Color(0xff25170B),
                          value: '1',
                          groupValue: selectedOptionPrice,
                          onChanged: (value) {
                            setState(() {
                              selectedOptionPrice = value;
                              debugPrint('selectedOptionPrice$selectedOptionPrice');
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
                const Divider(
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
                SizedBox(
                  height: size.height * 0.1,
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
                                color: selectedOptionRate == '0' ? kPrimaryColor : const Color(0xff25170B)),
                          ),
                          activeColor: selectedOptionRate == '0' ? kPrimaryColor : const Color(0xff25170B),
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
                                color: selectedOptionRate == '1' ? kPrimaryColor : const Color(0xff25170B)),
                          ),
                          activeColor: selectedOptionRate == '1' ? kPrimaryColor : const Color(0xff25170B),
                          value: '1',
                          groupValue: selectedOptionRate,
                          onChanged: (value) {
                            setState(() {
                              selectedOptionRate = value;
                              debugPrint('selectedOptionRate$selectedOptionRate');
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
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                  ),
                  child: InkWell(
                      onTap: () {
                        BlocProvider.of<FilterCubit>(context).getFilter(id: id!, brandsSelected: brandsSelected, intValueBestSeller: intValueBestSeller, selectedOptionPrice: selectedOptionPrice?? '', selectedOptionRate: selectedOptionRate?? '');

                      },
                      child: const FilterBodyBloc( )),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
