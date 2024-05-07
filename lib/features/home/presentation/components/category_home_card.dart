import 'package:e_commerce/constant/font_size.dart';
import 'package:flutter/material.dart';

import '../../../../../api/api.dart';
import '../../../../../models/homeModel.dart';

class CategoryHomeCard extends StatelessWidget {
  final List<Category>? category;
  final int index;
  const CategoryHomeCard({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    Api api = Api();

    return  Card(
      color: Color(int.parse(category![index].color.replaceAll('#', '0xFF'))),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FutureBuilder<Widget>(
                future: api.getImageHome(category![index].image),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final imageWidget = snapshot.data;
                    return imageWidget != null
                        ? SizedBox(
                      child: imageWidget,
                    )
                        : const SizedBox(); //
                  }
                }),

            const SizedBox(
              height: 15,
            ),
            Text(
              category![index].name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize:getResponsiveFontSize(context, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
