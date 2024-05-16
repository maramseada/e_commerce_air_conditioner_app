import 'package:e_commerce/features/more/presentation/components/locations/city/cities_drop_down_bloc.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/address.dart';
import '../../../../../models/places.dart';
import '../../components/locations/area/areas_drop_down_bloc.dart';
import '../../components/locations/building_textfield.dart';
import '../../components/locations/nearby_location_widget.dart';
import '../../components/locations/street_textfield.dart';
import '../../components/locations/town/towns_drop_down_bloc.dart';
import '../../components/locations/update_address_button/update_address_button_bloc.dart';

class EditAddress extends StatefulWidget {
  final Address address;
  const EditAddress({super.key, required this.address});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

String? buildingText;
String? street;
String? landmark;

class _EditAddressState extends State<EditAddress> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            shadowColor: Colors.white,
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
            title: Text(
              'تعديل العنوان',
              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
            ),
          ),
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
                child: Column(
                  children: [
                    const AreasDropDownBloc(),
                    CitiesDropDownBloc(
                      city: Places(id: widget.address.city!.id, name: widget.address.city!.name),
                    ),
                    TownsDropDownBloc(town: Places(id: widget.address.town!.id, name: widget.address.town!.name)),
                    BuildingTextField(
                      buildingNumber: widget.address.buildingNum,
                    ),
                    StreetTextField(
                      streetInitial: widget.address.street,
                    ),
                    NearByLocationWidget(
                      landmarkInitial: widget.address.landmark,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<LocationsCubit>(context).updateAddress(id: widget.address.id!, context: context);
                      },
                      child: const UpdateAddressButtonBloc(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
