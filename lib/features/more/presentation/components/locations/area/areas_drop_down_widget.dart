
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constant/colors.dart';
import '../../../../../../models/places.dart';

class AreasDropDownWidget extends StatefulWidget {
  final List<Places> areas;
  const AreasDropDownWidget({super.key, required this.areas});

  @override
  State<AreasDropDownWidget> createState() => _AreasDropDownWidgetState();
}
late int areaId;
class _AreasDropDownWidgetState extends State<AreasDropDownWidget> {
  late String selectedAreaName;

  @override
  void initState() {
    super.initState();
    selectedAreaName = widget.areas.isNotEmpty ? widget.areas[0].name : '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        top: 40,
        left: size.width * 0.035,
        right: size.width * 0.035,
      ),
      child: DropdownButtonFormField<String>(
          value: selectedAreaName,

          icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFFafafaf),
        ),
        decoration: InputDecoration(
          hintText: widget.areas[0].name,
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
        items: widget.areas.map((place) {
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
    selectedAreaName = value;
    Places selectedPlace = widget.areas.firstWhere((place) => place.name == value);
    BlocProvider.of<LocationsCubit>(context).areaId = selectedPlace.id;
    BlocProvider.of<LocationsCubit>(context).getCity(id: selectedPlace.id);
    });
    }}
      ),
    );
  }
}
