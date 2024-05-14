import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/app_constants.dart';
import '../../../../../core/constant/navigator.dart';
import '../../../data/models/projectsCategory.dart';
import '../../controllers/our_projects_cubit.dart';
import '../../screens/our_project_details.dart';
import 'our_projects_grid_view_item.dart';

class OurProjectsDetailsGridView extends StatelessWidget {
  final List<Projects> projects;
  const OurProjectsDetailsGridView({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: size.height * 0.01),
      child: GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.88,
        ),
        itemCount: projects.length, // Set the number of items in the grid
        itemBuilder: (context, index) {
          return OurProjectsGridViewItem(project: projects[index],);
        },
      ),
    );
  }
}
