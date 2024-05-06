import 'package:e_commerce/presentation/screens/home/presentation/controllers/Carousel/carousel_cubit.dart';
import 'package:e_commerce/presentation/screens/home/presentation/controllers/Home/home_cubit.dart';
import 'package:e_commerce/presentation/screens/home/presentation/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/more/morePage.dart';
import '../screens/our_projects/ourProjectsPage.dart';
import '../screens/our_work/ourWorkPage.dart';
import '../screens/shoppingCart/shoppingCartPage.dart';

class BottomBarPage extends StatefulWidget {
  BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _selectedIndex = 0;

  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List _widgetOptions = [
    HomePage(),
    ShoppingPage(),
    ourProjectsPage(),
    ourWorkPage(),
    morePage(),
  ];
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeCubit>(context).getHome();
    BlocProvider.of<CarouselHomeCubit>(context).getCarouselHome();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _widgetOptions[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _selectedIndex == 0 ? SvgPicture.asset('assets/images/Group 176135.svg') : SvgPicture.asset('assets/images/Group 176124.svg'),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1 ? SvgPicture.asset('assets/images/Group 176134.svg') : SvgPicture.asset('assets/images/Group 176123.svg'),
                label: 'العربة',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2 ? SvgPicture.asset('assets/images/Group 176136.svg') : SvgPicture.asset('assets/images/Group 176130.svg'),
                label: 'مشاريعنا',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 3 ? SvgPicture.asset('assets/images/Group 176137.svg') : SvgPicture.asset('assets/images/Group 176132.svg'),
                label: 'أعمالنا',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 4 ? SvgPicture.asset('assets/images/Group 176133.svg') : SvgPicture.asset('assets/images/Group 176129.svg'),
                label: 'المزيد',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFF1D75B1),
            onTap: _onItemTapped,
          ),
        ));
  }

  void _onItemTapped(int index) {
    if (index == 0 || _selectedIndex == 0) {
      setState(() {
        _selectedIndex = index;
        BlocProvider.of<HomeCubit>(context).getHome();
      });
    }
    setState(() {
      _selectedIndex = index;
    });
  }
}
