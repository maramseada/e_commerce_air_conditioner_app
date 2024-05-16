import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../models/places.dart';
import '../../../controllers/locations_cubit/locations_cubit.dart';
import '../../../controllers/locations_cubit/locations_state.dart';
import '../city/cities_drop_down_widget.dart';
import 'loading_widget_cities.dart';

class CitiesDropDownBloc extends StatelessWidget {
  final Places city;
  const CitiesDropDownBloc({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsCubit, LocationsState>(
      builder: (BuildContext context, state) {
        if (state is LocationsCitiesLoading) {
          return const CitiesLoadingWidget();
        } else if (state is LocationsCitiesSuccess) {
          return CitiesDropDownWidget(
            cities: state.cities,
          );
        } else if (state is LocationsCitiesFailure) {
          return const SizedBox();
        } else {
          return CitiesDropDownWidget(cities: BlocProvider.of<LocationsCubit>(context).cities ?? [city]);
        }
      },
    );
  }
}
