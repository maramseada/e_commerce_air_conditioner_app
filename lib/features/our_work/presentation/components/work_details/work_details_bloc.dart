import 'package:e_commerce/features/our_work/presentation/components/work_details/work_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/works.dart';
import '../../controllers/our_work_cubit.dart';
import '../../controllers/our_works_state.dart';

class WorkDetailsBloc extends StatelessWidget {
  const WorkDetailsBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OurWorkCubit, OurWorkState>(builder: (BuildContext context, state){
      if (state is OurWorkLoading){
        return const Center(child: CircularProgressIndicator());
      }else if (state is OurWorkSuccess){
        List<Works> works =state.work;

        return  WorkDetailsBody(works: works);
      }   else if (state is OurWorkFailure) {
        return const Center(child: Text('يوجد مشكله في الاتصال بالنترنت يرحى اعاده المحاوله لاحقا'));
      }
      else{       return  const SizedBox();
      }
    },);
  }
}
