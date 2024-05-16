import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../area/areas_drop_down_widget.dart';

class AreasDropDownBloc extends StatelessWidget {
  const AreasDropDownBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsCubit, LocationsState>(
      builder: (BuildContext context, state) {
        if (state is LocationsAreasLoading) {
          return const CircularProgressIndicator();
        } else if (state is LocationsAreasSuccess) {
          return AreasDropDownWidget(areas: state.areas);
        } else {
          return AreasDropDownWidget(areas: BlocProvider.of<LocationsCubit>(context).areas);
        }
      },
    );
  }
}
