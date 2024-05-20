import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/brandModel.dart';
import '../components/filter/filter_body.dart';
import '../controllers/filter/brands_cubit.dart';
import '../controllers/filter/brands_state.dart';

class Filter extends StatefulWidget {
  int? categoryId;
  String productName;
  Filter({super.key, this.categoryId, required this.productName});

  @override
  State<Filter> createState() => _FilterState();
}


int? id;
String? name;


class _FilterState extends State<Filter> {
  List<BrandModel>? brand;
  @override
  void initState() {
    super.initState();
    id = widget.categoryId;
    name = widget.productName;
    BlocProvider.of<BrandsCubit>(context).getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsCubit, BrandsState>(
      builder: (BuildContext context, state) {
        if (state is BrandsLoading) {
          return const SizedBox();
        } else if (state is BrandsSuccess) {
          brand = state.brand;
          return FilterBody(
            brand: brand,
          );
        } else if (state is BrandsFailure) {
          return const Center(child: Text('يوجد خطأ في الاتصال بالنترنت يرجى اعاده المحاولة لاحقا '));
        } else {
          return const SizedBox();
        }
      },

    );
  }


}
