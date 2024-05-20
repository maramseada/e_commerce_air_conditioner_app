import 'package:e_commerce/features/home/presentation/controllers/categories/categories_cubit.dart';
import 'package:e_commerce/features/home/presentation/controllers/categories/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import '../../screens/typesDetails.dart';

class CategoriesBodyBloc extends StatelessWidget {
  final int productId;
  final String productName;
  const CategoriesBodyBloc({super.key, required this.productName, required this.productId});

  @override
  Widget build(BuildContext context) {
    late List<ProductsModel> products;

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (BuildContext context, state) {
        if (state is CategoriesSuccess) {
          products = BlocProvider.of<CategoriesCubit>(context).products;
          return TypesDetails(products: products, productId: productId, productName: productName,);
        } else if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }   else {
          return const Center(child: Text('يوجد مشكله في الاتصال بالنترنت يرجى اعاده المحاوله لاحقا'));
        }
      },

    );
  }
}

