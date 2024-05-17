import 'package:e_commerce/features/more/presentation/components/about_company/about_company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/about_company/about_company_top_view.dart';
import '../components/about_company/our_advantages.dart';
import '../components/about_company/our_message.dart';
import '../controllers/guidlines_cubit/guidlines_cubit.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({super.key});

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  @override
  void initState() {
    BlocProvider.of<GuidLinesCubit>(context).aboutCompany();
 super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    AboutCompanyTopView(),
                    AboutCompanyBloc(),
                    OurMessage(),
                    OurAdvantages(),
                  ],
                )))));
  }
}
