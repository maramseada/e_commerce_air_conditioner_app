import 'package:e_commerce/features/home/presentation/controllers/categories/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constant/navigator.dart';
import '../../../../../../models/homeModel.dart';
import 'categories_body_bloc.dart';
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

            BlocProvider.of<CategoriesCubit>(context).getCategories(id: category![index].id,);
            navigateTo(
              context,
              CategoriesBodyBloc(
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
