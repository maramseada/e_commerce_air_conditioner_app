import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../api/address_api.dart';
import '../../../api/api.dart';
import '../../../constant/colors.dart';
import '../../../models/address.dart';
import '../../../models/places.dart';

class EditAddress extends StatefulWidget {
  Address address;
  EditAddress({super.key, required this.address});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  String? buildingText;
  String? street;
  String? landmark;
  late Future<dynamic> _areasFuture;
  late Future<dynamic> _citiesFuture = Future.value([]);
  late Future<dynamic> _townsFuture = Future.value([]);

  int? areaId; // Declare areaId as a member variable
  int? cityId;
  int? townID;
  bool progress = false;
  List<String> errors = [];
  ApiAddress _api = ApiAddress();

  TextEditingController buildingController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _areasFuture = _api.getArea();
    // _citiesFuture = _api.getCity(areaId ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ApiAddress _api = ApiAddress();

    Widget buildDropdown(List<Places> areas) {
      return Container(
        padding: EdgeInsets.only(
          top: 40,
          left: size.width * 0.035,
          right: size.width * 0.035,
        ),
        child: DropdownButtonFormField<String>(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFFafafaf),
          ),
          decoration: InputDecoration(
            hintText: widget.address.area!.name,
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
          items: areas.map((place) {
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
            // Check if value is not null
            if (value != null) {
              setState(() {
                Places? selectedPlace = areas.firstWhereOrNull((place) => place.name == value);
                if (selectedPlace != null) {
                  areaId = selectedPlace.id;
                  print('Selected area ID: $areaId');
                  // Update _citiesFuture with the new areaId
                  _citiesFuture = _api.getCity(areaId!);
                }
              });
            }
          },
        ),
      );
    }

    Widget buildDropdowncity(List<Places> cities) {
      // Get the default city name
      String? defaultCityName;
      if (cities.isNotEmpty) {
        defaultCityName = cities.first.name;
        cityId = cities.first.id; // Set the cityId to the ID of the first city
      }

      return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: size.width * 0.035,
          right: size.width * 0.035,
        ),
        child: DropdownButtonFormField<String>(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFFafafaf),
          ),
          decoration: InputDecoration(
            hintText: widget.address.city!.name,
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
          items: cities.map((place) {
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
            // Check if value is not null
            if (value != null) {
              // Find the selected city directly by name
              setState(() {
                Places? selectedCity = cities.firstWhereOrNull((city) => city.name == value);
                if (selectedCity != null) {
                  cityId = selectedCity.id;
                  print('Selected city ID: $cityId');
                  // Update the towns based on the selected city
                  _townsFuture = _api.getTown(cityId!);
                }
              });
            }
          },
        ),
      );
    }

    Widget buildDropdownTown(List<Places> towns) {
      // Get the default town name
      String? defaultTownName;
      if (towns.isNotEmpty) {
        defaultTownName = towns.first.name;
        townID = towns.first.id; // Set the townID to the ID of the first town
      }

      return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: size.width * 0.035,
          right: size.width * 0.035,
        ),
        child: DropdownButtonFormField<String>(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFFafafaf),
          ),
          decoration: InputDecoration(
            hintText: widget.address.town!.name,
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
          items: towns.map((place) {
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
            // Check if value is not null
            if (value != null) {
              // Find the selected town directly by name
              setState(() {
                Places? selectedTown = towns.firstWhereOrNull((town) => town.name == value);
                if (selectedTown != null) {
                  townID = selectedTown.id;
                  print('Selected town ID: $townID');
                }
              });
            }
          },
        ),
      );
    }

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
              icon: Icon(
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
                  child:  Column(
                      children: [
                        FutureBuilder(
                          future: _areasFuture,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              List area = snapshot.data;

                              if (area == null) {
                                print('Places is null');
                                return const Center(
                                  child: Text('هناك خطأ ما أعد تحميل الصفحة'),
                                );
                              } else {
                                List<Places> areas = List.generate(
                                  area.length,
                                  (index) => Places.fromJson(area[index]),
                                );

                                return buildDropdown(areas);
                              }
                            }
                          },
                        ),
                        FutureBuilder(
                          future: _citiesFuture,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              List city = snapshot.data;

                              if (city == null) {
                                print('Cities is null');
                                return const Center(
                                  child: Text('هناك خطأ ما أعد تحميل الصفحة'),
                                );
                              } else {
                                List<Places> cities = List.generate(
                                  city.length,
                                  (index) => Places.fromJson(city[index]),
                                );

                                return buildDropdowncity(cities);
                              }
                            }
                          },
                        ),
                        FutureBuilder(
                          future: _townsFuture,
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              List town = snapshot.data;

                              if (town == null) {
                                print('Towns is null');
                                return const Center(
                                  child: Text('هناك خطأ ما أعد تحميل الصفحة'),
                                );
                              } else {
                                List<Places> towns = List.generate(
                                  town.length,
                                  (index) => Places.fromJson(town[index]),
                                );

                                return buildDropdownTown(towns);
                              }
                            }
                          },
                        ),

                        //رقم المبنى
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: size.width * 0.035,
                            right: size.width * 0.035,
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              buildingText = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'برجاء ادخال رقم المبنى ';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: widget.address.buildingNum,
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
                          ),
                        ),
                        //الشارع
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: size.width * 0.035,
                            right: size.width * 0.035,
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              street = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'برجاء ادخال رقم الشارع ';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: widget.address.street,
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
                          ),
                        ),
//أقرب علامة مميزة للعنوان
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: size.width * 0.035,
                            right: size.width * 0.035,
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              landmark = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'برجاء ادخال أقرب علامة مميزة للعنوان ';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: widget.address.landmark,
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
                          ),
                        ),
                        GestureDetector(
                          onTap: () {

                            updateAddress();
                          },
                          child: Container(
                              width: double.infinity,
                              height: size.height * 0.079,
                              margin: EdgeInsets.only(
                                top: 30,
                                left: size.width * 0.035,
                                right: size.width * 0.035,
                              ),
                              decoration: ShapeDecoration(
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
                              ),
                              child: Center(
                                child: Text(
                                  'حفظ العنوان',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.05,
                                    fontFamily: 'Almarai',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
            ),
          ),
        ));
  }

  void updateAddress() async {
    Address add = Address(
      id: widget.address.id,
      street: street?? widget.address.street,
      buildingNum: buildingText?? widget.address.buildingNum,
      landmark: landmark?? widget.address.landmark,
      townId: townID,
    );
    setState(() {
      progress = true;
      street = streetController.text;
      buildingText = buildingController.text;
      landmark = landmarkController.text;
    });

      try {
        Map<String, dynamic>? response = await _api.updateAddress(add);
        print('first_name$street');
        print('phone$buildingText');
        print('lastname$landmark');

        if (response != null && response['status'] == 200) {


        Fluttertoast.showToast(
            msg: 'address updated',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.pop(context);
          print('navigation complete');
        } else {
          if (response != null && response['message'] != null) {
            setState(() {
              if (response['message'] is String) {
                errors = [response['message']];
              } else if (response['message'] is List<dynamic>) {
                errors = response['message'].cast<String>();
              }
            });
          }
        }
      } catch (e) {
        print('Network Error: $e');
        setState(() {
          errors = ['Network error occurred. Please check your connection.'];
        });
      } finally {
        setState(() {
          progress = false;
        });
      }

  }
}
