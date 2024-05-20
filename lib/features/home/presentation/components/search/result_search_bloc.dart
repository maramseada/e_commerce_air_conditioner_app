import 'package:e_commerce/features/home/presentation/components/search/result_search_body.dart';
import 'package:e_commerce/features/home/presentation/controllers/search/search_cubit.dart';
import 'package:e_commerce/features/home/presentation/controllers/search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/ordermodel.dart';
import 'empty_search.dart';

class ResultSearchBloc extends StatelessWidget {
  final String searchQuery;

  const ResultSearchBloc({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    late  List<ProductsModel> products;

    return BlocBuilder<SearchCubit, SearchState>(
        builder: (BuildContext context, state) {
          if(state is SearchLoading){
            return const Center(child: CircularProgressIndicator());
          }else if (state is SearchSuccess){
products = state.products;

            return ResultSearchBody(searchQuery: searchQuery, products: products,);
          }else{
            return const EmptySearch();
          }
        }

    );
  }
}
