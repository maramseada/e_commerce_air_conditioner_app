
import 'package:flutter/cupertino.dart';

import '../../../../../../models/favourite_product_model.dart';
import '../../../../../../models/ordermodel.dart';
import '../../data/models/project.dart';
import '../../data/models/projectsCategory.dart';

@immutable
abstract class OurProjectsState {

}

class OurProjectsInitial extends OurProjectsState{}
class OurProjectsLoading extends OurProjectsState{}
class OurProjectsDataSuccess extends OurProjectsState{
  List<Projects> data;
  OurProjectsDataSuccess({ required this.data});


}class OurProjectsSuccess extends OurProjectsState{
  List<Project> project;
  OurProjectsSuccess({ required this.project });


}
class OurProjectsFailure extends OurProjectsState{
  String errMessage;
  OurProjectsFailure({required this.errMessage});


}
