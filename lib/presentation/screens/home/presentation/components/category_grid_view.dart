import 'package:flutter/material.dart';

import '../../../../../constant/navigator.dart';
import '../../../../../models/homeModel.dart';
import '../screens/typesDetails.dart';
import 'category_home_card.dart';

class CategoryGridView extends StatelessWidget {
  final List<Category>? category;

  const CategoryGridView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: category!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            navigateTo(
              context,
              TypesDetails(
                productId: category![index].id,
                productName:category![index].name,
              ),
            );
          },
          child:CategoryHomeCard(category: category ,index: index,),
        );
      },
    );
  }
}
