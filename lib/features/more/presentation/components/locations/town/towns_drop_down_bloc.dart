import 'package:e_commerce/features/more/presentation/components/locations/town/towns_drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/places.dart';
import '../../../controllers/locations_cubit/locations_cubit.dart';
import '../../../controllers/locations_cubit/locations_state.dart';

class TownsDropDownBloc extends StatelessWidget {
  final Places town;
  const TownsDropDownBloc({super.key, required this.town});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LocationsCubit, LocationsState>(builder: (BuildContext context, state) {
      if (state is LocationsTownsSuccess) {
        return TownsDropDownWidget(
          towns: state.towns,
        );
      } else if (state is LocationsTownsFailure) {
        return const SizedBox();
      } else {
        return TownsDropDownWidget(towns: BlocProvider.of<LocationsCubit>(context).towns ?? [town]);
      }
    });
  }
}
