import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../models/places.dart';
import '../../components/locations/add_address/add_address_button_bloc.dart';
import '../../components/locations/add_address/building_test_filed_add_address.dart';
import '../../components/locations/add_address/nearby_add_address.dart';
import '../../components/locations/add_address/street_add_address.dart';
import '../../components/locations/area/areas_drop_down_bloc.dart';
import '../../components/locations/city/cities_drop_down_widget.dart';
import '../../components/locations/city/loading_widget_cities.dart';
import '../../components/locations/town/towns_drop_down_widget.dart';
import '../../controllers/locations_cubit/locations_cubit.dart';
import '../../controllers/locations_cubit/locations_state.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}
int? areaId; // Declare areaId as a member variable
int? cityId;
int? townID;
bool progress = false;
String? buildingTextAddAddress;
String? streetAddAddress;
String? landmarkAddAddress;
class _AddAddressScreenState extends State<AddAddressScreen> {


  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Set this property to true

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
          'إضافة عنوان جديد',
          style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
        ),
      ),
      body: SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'قم بإضافة بيانات العنوان',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w700,
                        fontSize: size.width * 0.035,
                        color: const Color(0xFF878383),
                      ),
                    ),
                  ),
                  const AreasDropDownBloc(),
                  BlocBuilder<LocationsCubit, LocationsState>(
                    builder: (BuildContext context, state) {
                      List<Places> city = [Places(id: 0, name: 'الحي')];

                    if (state is LocationsCitiesLoading) {
                        return const CitiesLoadingWidget();
                      } else if (state is LocationsCitiesSuccess) {
                        return CitiesDropDownWidget(
                          cities: state.cities,
                        );
                      } else if (state is LocationsCitiesFailure) {
                        return const SizedBox();
                      } else {
                        return CitiesDropDownWidget(cities: BlocProvider.of<LocationsCubit>(context).cities ?? city);
                      }
                    },
                  ),
                  BlocBuilder<LocationsCubit, LocationsState>(builder: (BuildContext context, state) {
                    List<Places> town = [Places(id: 0, name: 'المدينة')];
                    if (state is LocationsTownsSuccess) {
                      return TownsDropDownWidget(
                        towns: state.towns,
                      );
                    } else if (state is LocationsTownsFailure) {
                      return const SizedBox();
                    } else {
                      return TownsDropDownWidget(towns: BlocProvider.of<LocationsCubit>(context).towns ?? town);
                    }
                  }),
                  const BuildingTextFieldAddAddress(),
                  const StreetAddAddress(),
                  const NearByAddAddress(),
                  GestureDetector(
                    onTap: () {
                     BlocProvider.of<LocationsCubit>(context).addAddress();
                    },
                    child:const AddAddressButtonBloc(),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

}
