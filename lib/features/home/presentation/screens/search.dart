import 'package:flutter/material.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/images.dart';
import '../components/search/empty_search.dart';
import '../components/search/search_text_field.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            'البحث',
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SearchTextField(),
              const EmptySearch(),
              SizedBox(
                height: size.height * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


