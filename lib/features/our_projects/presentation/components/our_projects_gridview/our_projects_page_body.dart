import 'package:e_commerce/features/our_projects/presentation/controllers/our_projects_cubit.dart';
import 'package:e_commerce/features/our_projects/presentation/controllers/our_projects_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/projectsCategory.dart';
import 'our_projects_details_grid_view.dart';

class OurProjectsPageBody extends StatelessWidget {
  const OurProjectsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
   late  List <Projects> projects;

    return BlocConsumer<OurProjectsCubit, OurProjectsState>(builder: (BuildContext context, state){
      if (state is OurProjectsLoading){
        return const Center( child: CircularProgressIndicator());
      }else if (state is OurProjectsDataSuccess){
        projects = state.data;
      return   OurProjectsDetailsGridView(projects: projects,);
      }   else if (state is OurProjectsFailure) {
      return const Center(child: Text('يوجد مشكله في الاتصال بالنترنت يرحى اعاده المحاوله لاحقا'));
    }
    else{       return OurProjectsDetailsGridView(projects: projects,);
    }
    }, listener: (BuildContext context, OurProjectsState state) {

    },);
  }
}
