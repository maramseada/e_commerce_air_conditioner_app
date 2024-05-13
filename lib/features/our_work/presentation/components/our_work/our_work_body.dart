import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/works.dart';
import '../../controllers/our_work_cubit.dart';
import '../../controllers/our_works_state.dart';
import 'our_work_body_list_view.dart';

class OurWorkBody extends StatelessWidget {
  const OurWorkBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<Works> works = [];
    return BlocBuilder<OurWorkCubit, OurWorkState>(
      builder: (BuildContext context, state) {
        if (state is OurWorkLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OurWorkDataSuccess) {
          Map<String, dynamic> data = state.data;

          data.forEach((key, value) {
            works.add(Works.fromJson(value));
          });

          return OurWorkBodyListView(
            works: works,
          );
        } else if (state is OurWorkFailure) {
          return const Center(child: Text('يوجد مشكله في الاتصال بالنترنت يرحى اعاده المحاوله لاحقا'));
        } else {
          return OurWorkBodyListView(
            works: works,
          );
        }
      },

    );
  }
}
