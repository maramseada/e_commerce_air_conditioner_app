import 'package:e_commerce/features/our_projects/presentation/controllers/our_projects_cubit.dart';
import 'package:e_commerce/features/our_projects/presentation/controllers/our_projects_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/project.dart';
import 'our_projects_list_view.dart';

class OurProjectsDetailsBody extends StatelessWidget {
  const OurProjectsDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<Project>? projects;
    return BlocBuilder<OurProjectsCubit, OurProjectsState>(builder: (BuildContext context, state) {
      if (state is OurProjectsLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is OurProjectsSuccess) {
        projects = state.project;
        return OurProjectsListView(projects: projects!,);
      } else if (state is OurProjectsFailure) {
        return const Center(child: Text('يوجد مشكله في الاتصال بالنترنت يرحى اعاده المحاوله لاحقا'));
      }
      else{
        return SizedBox();
      }
    });
  }
}

