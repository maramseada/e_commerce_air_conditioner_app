import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widgets/button.dart';
import '../../controllers/filter/filter_cubit.dart';
import '../../controllers/filter/filter_state.dart';
import '../../screens/typesDetails.dart';

class FilterBodyBloc extends StatefulWidget {
  const FilterBodyBloc({Key? key}) : super(key: key);

  @override
  State<FilterBodyBloc> createState() => _FilterBodyBlocState();
}

class _FilterBodyBlocState extends State<FilterBodyBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterState>(
      builder: (BuildContext context, state) {
        if (state is FilterSuccess) {
          filteredData = state.products; // Update filteredData with state products
          return const Button(
            text: 'فلترة',
          );
        } else if (state is FilterLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Button(
            text: 'فلترة',
          );
        }
      },
      listener: (BuildContext context, state) {
        if (state is FilterSuccess) {
          setState(() {
            filteredData = state.products;
          });
          Navigator.pop(context);
        }
      },
    );
  }
}
