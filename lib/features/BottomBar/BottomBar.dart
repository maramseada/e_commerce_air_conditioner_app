import 'package:e_commerce/features/our_projects/presentation/controllers/our_projects_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home/presentation/controllers/Carousel/carousel_cubit.dart';
import '../home/presentation/controllers/Home/home_cubit.dart';
import '../home/presentation/controllers/best_sellers/best_sellers_cubit.dart';
import '../home/presentation/screens/home.dart';
import '../more/presentation/screens/more_page.dart';
import '../our_projects/presentation/screens/our_projects_page.dart';
import '../our_work/presentation/controllers/our_work_cubit.dart';
import '../our_work/presentation/screens/ourWorkPage.dart';
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

  final List _widgetOptions = [
    HomePage(),
    ShoppingPage(),
    OurProjectsPage(),
    OurWorkPage(),
    MorePage(),
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
    if (index == 2 || _selectedIndex == 2) {
      setState(() {
        _selectedIndex = index;
        BlocProvider.of<OurProjectsCubit>(context).getProjectsCategories();

      });
    }   if (index == 3|| _selectedIndex == 3) {
      setState(() {
        _selectedIndex = index;
        BlocProvider.of<OurWorkCubit>(context).getWorksCategories();

      });
    }
    setState(() {
      _selectedIndex = index;
    });
  }
}
