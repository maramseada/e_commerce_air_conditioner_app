import 'package:e_commerce/features/our_work/presentation/components/our_work/our_works_list_item.dart';
import 'package:e_commerce/features/our_work/presentation/controllers/our_work_cubit.dart';
import 'package:e_commerce/features/our_work/presentation/screens/works_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/works.dart';

class OurWorkBodyListView extends StatefulWidget {
  final List<Works> works;
  const OurWorkBodyListView({super.key, required this.works});

  @override
  State<OurWorkBodyListView> createState() => _OurWorkBodyListViewState();
}

class _OurWorkBodyListViewState extends State<OurWorkBodyListView> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: List.generate(
          widget.works.length,
              (index) => GestureDetector(

            onTap: () {
              BlocProvider.of<OurWorkCubit>(context).getWorkByType(type:widget.works[index].type,);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>     WorksDetails(
                    type: widget.works[index].type,

                  ),
                ),
              ).then((_) {
                if (mounted) {
                  setState(() {
                    BlocProvider.of<OurWorkCubit>(context).getWorksCategories();
                  });
                }
              });
            },
            child:OurWorkListItem(work: widget.works[index])
          ),
        ),
      ),
    );
  }
}
