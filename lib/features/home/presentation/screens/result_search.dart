import 'package:e_commerce/features/home/presentation/components/search/result_search_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';


class ResultSearch extends StatelessWidget {
  final String searchQuery;

 const ResultSearch({Key? key, required this.searchQuery}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            'نتائج البحث',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w800,
              fontSize: size.width * 0.05,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ResultSearchBloc(searchQuery: searchQuery),
      ),
    );
  }
}
