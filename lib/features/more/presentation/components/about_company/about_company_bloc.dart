import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/settingsModel.dart';
import '../../controllers/guidlines_cubit/guidlines_cubit.dart';
import '../../controllers/guidlines_cubit/guidlines_state.dart';
import 'about_company_body.dart';

class AboutCompanyBloc extends StatelessWidget {
  const AboutCompanyBloc({super.key});

  @override
  Widget build(BuildContext context) {


      List<SettingsModel>? data;

      return  BlocBuilder<GuidLinesCubit, GuidLinesState>(builder: (BuildContext context, state){
        if(state is AboutCompanyLoading){
          return const SizedBox();
        }
        if (state is AboutCompanySuccess){
          data = BlocProvider.of<GuidLinesCubit>(context).data;
          return AboutCompanyBody(data: data!,);
        }else{
          return const SizedBox();
        }
      });
    }
  }

