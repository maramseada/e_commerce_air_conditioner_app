import 'package:e_commerce/constant/font_size.dart';
import 'package:flutter/material.dart';

import '../../../../../api/api.dart';
import '../../../../../models/homeModel.dart';
class CategoryHomeCard extends StatefulWidget {
  final List<Category>? category;
  final int index;
  const CategoryHomeCard({super.key, required this.category, required this.index});

  @override
  State<CategoryHomeCard> createState() => _CategoryHomeCardState();
}

class _CategoryHomeCardState extends State<CategoryHomeCard> {
  Api api = Api();



  @override
  Widget build(BuildContext context) {

    return  Card(
      color: Color(int.parse(widget.category![widget.index].color.replaceAll('#', '0xFF'))),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
              image:      NetworkImage(
                  'https://albakr-ac.com/${widget.category![widget.index].image}',
                    )
                )
              )
            ),


            const SizedBox(
              height: 15,
            ),
            Text(
              widget.category![widget.index].name,
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

