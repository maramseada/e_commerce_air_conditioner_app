import 'package:flutter/cupertino.dart';

import '../../../../../models/places.dart';



@immutable
abstract class LocationsState {

}
class LocationsInitial extends LocationsState{}
class LocationsLoading extends LocationsState{}
class LocationsSuccess extends LocationsState{
  LocationsSuccess();
}

class LocationsFailure extends LocationsState{
  String errMessage;
  LocationsFailure({required this.errMessage});
}
class LocationsUpdateAddressInitial extends LocationsState{}
class LocationsUpdateAddressLoading extends LocationsState{}
class LocationsUpdateAddressSuccess extends LocationsState{
  LocationsUpdateAddressSuccess();
}

class LocationsUpdateAddressFailure extends LocationsState{
  String errMessage;
  LocationsUpdateAddressFailure({required this.errMessage});
}


class LocationsAreasInitial extends LocationsState{}
class LocationsAreasLoading extends LocationsState{}

class LocationsAreasSuccess extends LocationsState{
  final List<Places> areas;
  LocationsAreasSuccess({required this.areas});
}
class LocationsAreasFailure extends LocationsState{
  String errMessage;
  LocationsAreasFailure({required this.errMessage});
}
class LocationsCitiesInitial extends LocationsState{}
class LocationsCitiesLoading extends LocationsState{}
class LocationsCitiesSuccess extends LocationsState{
  final List<Places> cities;
  LocationsCitiesSuccess({required this.cities});
}class LocationsCitiesFailure extends LocationsState{
  String errMessage;
  LocationsCitiesFailure({required this.errMessage});
}

class LocationsTownsInitial extends LocationsState{}
class LocationsTownsLoading extends LocationsState{}
class LocationsTownsSuccess extends LocationsState{
  final List<Places> towns;
  LocationsTownsSuccess({required this.towns});
}class LocationsTownsFailure extends LocationsState{
  String errMessage;
  LocationsTownsFailure({required this.errMessage});
}