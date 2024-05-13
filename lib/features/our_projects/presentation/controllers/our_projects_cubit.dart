import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dataSource/projects_api.dart';
import '../../data/models/project.dart';
import '../../data/models/projectsCategory.dart';
import 'our_projects_state.dart';

class OurProjectsCubit extends Cubit<OurProjectsState> {
  ProjectsApi api;
  late List<Projects> projects;
  late List<Project> project;
  OurProjectsCubit(
    this.api,
  ) : super(OurProjectsInitial());

  void getProjectsCategories() async {
    emit(OurProjectsLoading());
    try {
      projects = await api.projectCategories();
      emit(OurProjectsDataSuccess(data: projects)); // Update with the latest product state
    } on Exception catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      emit(OurProjectsFailure(errMessage: 'error cart : $e'));
    }
  }

  void getProjectByTypes({required int id}) async {
    emit( OurProjectsLoading());
    try{
    project = await api.projectByType(id: id.toString());
    emit(OurProjectsSuccess(project: project));
  }catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      emit(OurProjectsFailure(errMessage: '$e'));
    }}
}
