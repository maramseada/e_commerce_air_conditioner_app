import 'package:e_commerce/features/more/presentation/controllers/guidlines_cubit/guidlines_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/colors.dart';
import '../components/guid_lines/guil_lines_body_bloc.dart';

class GuideLines extends StatefulWidget {
  const GuideLines({super.key});

  @override
  State<GuideLines> createState() => _GuideLinesState();
}

class _GuideLinesState extends State<GuideLines> {
  @override
  void initState() {
BlocProvider.of<GuidLinesCubit>(context).guidLines();
super.initState();
  }
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
            body: const GuidLinesBodyBloc()));
  }
}
