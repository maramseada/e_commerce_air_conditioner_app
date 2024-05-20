import 'package:e_commerce/core/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyProductsFilter extends StatelessWidget {
  const EmptyProductsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SvgPicture.asset('assets/images/empty_screen.svg', color:  grayColor,),
Center(child: Text('kkkkkkkkkkkkkkkkkk')),

        ],
      ),
    );
  }
}
