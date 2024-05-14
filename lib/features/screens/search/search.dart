import 'package:e_commerce/core/constant/navigator.dart';
import 'package:e_commerce/features/screens/result_search/result_search.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/colors.dart';
import '../../../core/constant/images.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(      backgroundColor: Colors.white,

        appBar: AppBar(
          centerTitle: true,shadowColor: Colors.white,
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
            icon: Icon(
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

          /// TODO if no found search
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: TextFormField(
                  controller: searchController,

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
              ),
              Column(
                children: [
                  Image.asset(
                    noFoundSearch,
                    width: size.width * 0.25,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'عذا ,  لا توجد نتائج للبحث',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.05,
                      color: Color(0xff2D2525),
                    ),
                  ),
                ],
              ),
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
void _submitSearch(BuildContext context, String query) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultSearch(searchQuery: query),
    ),
  );
}
