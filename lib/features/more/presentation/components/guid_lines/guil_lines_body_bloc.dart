import 'package:e_commerce/features/more/presentation/controllers/guidlines_cubit/guidlines_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/guidlines_cubit/guidlines_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/settingsModel.dart';
import 'guildines_body.dart';

class GuidLinesBodyBloc extends StatelessWidget {
  const GuidLinesBodyBloc({super.key});

  @override
  Widget build(BuildContext context) {
    List<SettingsModel>? data;

    return  BlocBuilder<GuidLinesCubit, GuidLinesState>(builder: (BuildContext context, state){
      if(state is GuidLinesLoading){
        return const Center(child:  CircularProgressIndicator(),);
      }else   if (state is GuidLinesSuccess){
        data = BlocProvider.of<GuidLinesCubit>(context).data;
        return GuidLinesBody(data: data!,);
      }else{
        return const SizedBox();
      }
    });
  }
}
