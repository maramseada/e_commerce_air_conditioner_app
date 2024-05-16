import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../core/constant/colors.dart';
import '../../../../../../models/places.dart';
import '../../../controllers/locations_cubit/locations_cubit.dart';

class CitiesDropDownWidget extends StatefulWidget {
final  List<Places> cities;
  const CitiesDropDownWidget({super.key,  required this.cities});

  @override
  State<CitiesDropDownWidget> createState() => _CitiesDropDownWidgetState();
}
 int? cityId;
late String defaultCityName;

class _CitiesDropDownWidgetState extends State<CitiesDropDownWidget> {

  @override
  void initState() {
    super.initState();
    if (widget.cities.isNotEmpty) {
      cityId = widget.cities.first.id;
      defaultCityName = widget.cities.first.name;
    } else {
      cityId = null;
      defaultCityName = '';
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);




    return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: size.width * 0.035,
          right: size.width * 0.035,
        ),
        child: DropdownButtonFormField<String>(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFFafafaf),
          ),
          decoration: InputDecoration(
            hintText: defaultCityName,
            hintStyle: TextStyle(
              color: grayColor,
              fontSize: size.width * 0.04,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFF7F7F7),
              ),
              borderRadius: BorderRadius.circular(38),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(38),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(38),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFF7F7F7),
              ),
              borderRadius: BorderRadius.circular(38),
            ),
          ),
          value: defaultCityName, // Set the default value
          items: widget.cities.map((place) {
            return DropdownMenuItem<String>(
              value: place.name,
              child: Text(
                place.name,
                style: TextStyle(
                  color: grayColor,
                  fontSize: size.width * 0.04,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            if (value != null) {
              setState(() {
                Places? selectedCity = widget.cities.firstWhereOrNull((city) => city.name == value);
                if (selectedCity != null) {
                  cityId = selectedCity.id;
                  BlocProvider.of<LocationsCubit>(context).cityId = selectedCity.id;
                  BlocProvider.of<LocationsCubit>(context).getTowns(id: selectedCity.id);

                }
              });
            }
          },
        ),
      );

  }
}
