import 'package:e_commerce/features/more/presentation/components/return_policy/return_policy_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/settingsModel.dart';
import '../../controllers/guidlines_cubit/guidlines_cubit.dart';
import '../../controllers/guidlines_cubit/guidlines_state.dart';

class ReturnPolicyBodyBloc extends StatelessWidget {
  const ReturnPolicyBodyBloc({super.key});

  @override
  Widget build(BuildContext context) {

      List<SettingsModel>? data;

      return  BlocBuilder<GuidLinesCubit, GuidLinesState>(builder: (BuildContext context, state){
   if(state is ExchangeLoading){
     return const Center(child:  CircularProgressIndicator(),);
   }
        if (state is ExchangeSuccess){
          data = BlocProvider.of<GuidLinesCubit>(context).data;
          return ReturnPolicyBody(data: data!,);
        }else{
          return const SizedBox();
        }
      });
    }
  }

