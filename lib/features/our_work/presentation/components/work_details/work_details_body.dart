import 'package:e_commerce/features/our_work/presentation/components/work_details/work_details_body_item.dart';
import 'package:flutter/material.dart';

import '../../../data/models/works.dart';

class WorkDetailsBody extends StatelessWidget {
 final List <Works> works;
  const WorkDetailsBody({super.key, required this.works});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            works.length,
                (index) => GestureDetector(
              child:WorkDetailsBodyItem(work: works[index],),
            ),
          ),
        ),
      ),
    );
  }
}
