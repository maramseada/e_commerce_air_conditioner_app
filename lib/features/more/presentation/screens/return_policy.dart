import 'package:e_commerce/features/more/data/dataSource/settings_data_source.dart';
import 'package:e_commerce/features/more/presentation/components/return_policy/return_policy_body_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../api/api.dart';
import '../../../../core/constant/colors.dart';
import '../../../../models/settingsModel.dart';
import '../controllers/guidlines_cubit/guidlines_cubit.dart';

class ReturnPolicyScreen extends StatefulWidget {
  const ReturnPolicyScreen({super.key});

  @override
  State<ReturnPolicyScreen> createState() => _ReturnPolicyScreenState();
}

class _ReturnPolicyScreenState extends State<ReturnPolicyScreen> {
  @override
  void initState() {
    BlocProvider.of<GuidLinesCubit>(context).returnPolicy();
    super.initState();
  }  List<SettingsModel>? data;
  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                ),
              ),
            ),
            body: const ReturnPolicyBodyBloc()));
  }
}
