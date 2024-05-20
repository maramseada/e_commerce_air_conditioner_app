import 'package:e_commerce/features/home/presentation/controllers/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../screens/result_search.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: TextFormField(
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width * 0.04,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.right,
        onFieldSubmitted: (value) {
          _submitSearch(context, value);
        },
        onChanged: (value) {},
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            'assets/images/search.png',
            scale: size.width * 0.02,
          ),
          hintText: 'أدخل كلمة البحث',
          hintStyle: TextStyle(
            color: grayColor,
            fontSize: size.width * 0.04,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFF7F7F7),
            ),
            borderRadius: BorderRadius.circular(38),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(38),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(38),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFF7F7F7),
            ),
            borderRadius: BorderRadius.circular(38),
          ),
        ),
      ),
    );
  }void _submitSearch(BuildContext context, String query) {
    BlocProvider.of<SearchCubit>(context).getSearch(search: query);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultSearch(searchQuery: query),
      ),
    );
  }
}
