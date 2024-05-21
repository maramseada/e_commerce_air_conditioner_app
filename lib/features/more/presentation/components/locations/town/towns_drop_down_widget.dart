import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../models/places.dart';
import '../../../../../../core/constant/colors.dart';

class TownsDropDownWidget extends StatefulWidget {
  final List<Places> towns;
  const TownsDropDownWidget({super.key, required this.towns});

  @override
  State<TownsDropDownWidget> createState() => _TownsDropDownWidgetState();
}
int? townID;
class _TownsDropDownWidgetState extends State<TownsDropDownWidget> {
  @override
  Widget build(BuildContext context,) {
    Size size = MediaQuery.sizeOf(context);
    String? defaultTownName;
    if (widget.towns.isNotEmpty) {
      defaultTownName = widget.towns.first.name;
      townID = widget.towns.first.id; // Set the townID to the ID of the first town
    }

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
            hintText: defaultTownName,
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
          value: defaultTownName, // Set the default value
          items: widget.towns.map((place) {
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
                Places? selectedTown = widget.towns.firstWhereOrNull((town) => town.name == value);
                if (selectedTown != null) {
                  townID = selectedTown.id;
                  BlocProvider.of<LocationsCubit>(context).townId = selectedTown.id;         BlocProvider.of<LocationsCubit>(context).townIdAddAddress = selectedTown.id;
                }
              });
            }
          },
        ),
      );

  }
}
