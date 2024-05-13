
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dataSource/works_api.dart';
import '../../data/models/works.dart';
import 'our_works_state.dart';

class OurWorkCubit extends Cubit<OurWorkState> {
  WorksApi api;
  late Map<String, dynamic> works;
 late List<Works> worksType;
  OurWorkCubit(
      this.api,
      ) : super(OurWorkInitial());

  void getWorksCategories() async {
    emit(OurWorkLoading());
    try {
      works = await api.workCategories();
      emit(OurWorkDataSuccess(data: works)); // Update with the latest product state
    } on Exception catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      emit(OurWorkFailure(errMessage: 'error cart : $e'));
    }
  }

  void getWorkByType({required String type}) async {
    emit( OurWorkLoading());
    try{
  worksType = await api.workByType(type: type);
      emit(OurWorkSuccess(work: worksType));
    }catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      emit(OurWorkFailure(errMessage: '$e'));
    }}
}
