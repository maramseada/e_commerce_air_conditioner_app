
import 'package:flutter/material.dart';

import '../../../data/models/project.dart';
import 'our_projects_list_view_item.dart';

class OurProjectsListView extends StatelessWidget {
  final List <Project> projects;
  const OurProjectsListView({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return OurProjectsListViewItem(project: projects[index],);
      },
    );
  }
}
