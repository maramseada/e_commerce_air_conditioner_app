import 'package:e_commerce/features/home/presentation/controllers/best_sellers/best_sellers_state.dart';
import 'package:e_commerce/models/homeModel.dart';
import 'package:e_commerce/features/home/presentation/components/best_sellers_list_view.dart';
import 'package:e_commerce/features/home/presentation/components/carousel.dart';
import 'package:e_commerce/features/home/presentation/components/sparePieces.dart';
import 'package:e_commerce/features/home/presentation/screens/show_accessories.dart';
import 'package:e_commerce/features/home/presentation/screens/show_bestsellers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constant/font_size.dart';
import '../../../../../constant/navigator.dart';

import '../components/category_grid_view.dart';
import '../components/home_body_appbar.dart';
import '../controllers/best_sellers/best_sellers_cubit.dart';

class HomeBody extends StatefulWidget {
  final HomeModel? home;
  const HomeBody({super.key, required this.home});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: ListView(
        shrinkWrap: true,
        children: widget.home != null
            ? [
                HomeAppBar(
                  home: widget.home,
                ),
                const Center(
                  child: CarouselScreen(),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: CategoryGridView(category: widget.home!.categories)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: size.height * 0.018),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الأكثر مبيعا',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: getResponsiveFontSize(context, fontSize: 20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.009,
                          ),
                          Text(
                            'أكثر منتجاتنا تحقيقا للمبيعات',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Almarai',
                              fontSize: getResponsiveFontSize(context, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<BestSellersCubit>(context).getBestSellers();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>      const ShowBestSellers(
                                    productName: 'الأكثر مبيعا',
                                  ))).then((_) => setState(() {}));

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'عرض المزيد',
                              style: TextStyle(
                                color: const Color(0xFFCA7009),
                                fontSize: getResponsiveFontSize(context, fontSize: 16),
                                fontFamily: 'Almarai',
                              ),
                            ),
                            SizedBox(width: size.width * 0.025),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: const Color(0xFFCA7009),
                              size: size.width * 0.044,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          BestSeller(),

          Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.025, vertical: size.height * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'فتحات التكييف الألومنيوم',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: getResponsiveFontSize(context, fontSize: 20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.009,
                          ),
                          Text(
                            'مبيعات فتحات التكييف الألومنيوم المتاحة لدينا',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Almarai',
                              fontSize: getResponsiveFontSize(context, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          navigateTo(
                            context,
                            ShowMoreAccessories(
                              productName: 'فتحات التكييف الألومنيوم',
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'عرض المزيد',
                              style: TextStyle(
                                color: const Color(0xFFCA7009),
                                fontSize: getResponsiveFontSize(context, fontSize: 16),
                                fontFamily: 'Almarai',
                              ),
                            ),
                            SizedBox(width: size.width * 0.025),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: const Color(0xFFCA7009),
                              size: size.width * 0.044,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          Padding(
                  padding: EdgeInsets.only(right: size.width * 0.018),
                  child: SparePieceScreen(),
                ),
              ]
            : [
                const Center(
                  child: Text(
                    'لا تتوفر بيانات تأكد من اتصال الانترنت ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                    ),
                  ),
                ),
              ],
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
