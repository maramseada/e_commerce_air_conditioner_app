import 'package:flutter/material.dart';

import '../../../../api/cart_api.dart';
import '../../../../constant/colors.dart';
import '../../../../models/address.dart';
import '../../../../models/cart_model.dart';

class SelectSaveTitleWidget extends StatefulWidget {
  const SelectSaveTitleWidget({super.key});

  @override
  State<SelectSaveTitleWidget> createState() => _SelectSaveTitleWidgetState();
}
class _SelectSaveTitleWidgetState extends State<SelectSaveTitleWidget> {
  String? installingOptions;
  int selectedIndex = 0;
  CartApi _api = CartApi();
  List<Address>? data;
  bool isSelectingAddress = false;
  List<String> errors = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add form key

  @override
  void initState() {
    super.initState();
    installingOptions = data != null && data!.isNotEmpty ? data![0].id.toString() : null;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _api.getAddresses(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null) {
          return Container();
        } else {
          data = snapshot.data;
          return Form(
            key: _formKey,

            child: ListView.builder(
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      installingOptions = data![index].id.toString();
                      selectedIndex = index;
                      print('selected index $selectedIndex');
                      print('selected option $installingOptions');
                      selectAddress();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(bottom: size.height * 0.015,left:size.width*0.02,right:size.width*0.02,),
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? Color(0xFFEFF5F9) : Color(0xffEAEAEA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedIndex == index ? Color(0xB31D75B1) : Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          value: data![index].id.toString(),
                          groupValue: installingOptions,
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = index;
                              installingOptions = value as String;
                              print(';lskmdlknfjnfej${data![index].id}');
                            });
                          },
                          activeColor: installingOptions == data![index].id.toString() ? kPrimaryColor : Color(0xff25170B),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data![index].area!.name} ${data![index].city!.name}',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.037,
                                color: Color(0xff25170B),
                              ),
                            ),
                            Text(
                              '${data![index].town!.name} ${data![index].buildingNum} ${data![index].street} ${data![index].landmark ?? ""}',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.033,
                                color: Color(0xff25170B),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }


  void selectAddress() async {
    // Validate form before submission
      setState(() {
        isSelectingAddress = true;
      });

      try {
        print('Product ID: $installingOptions');

        // Call the API with the updated values
        Map<String, dynamic>? response = await _api.selectAddress(
            installingOptions!
        );

        // Handle the API response
        if (response != null && response['status'] == 200) {
          print('Product updated successfully');
        } else {
          // Handle error response
          setState(() {
            if (response != null && response['message'] != null) {
              if (response['message'] is String) {
                errors = [response['message']];
              } else if (response['message'] is List<dynamic>) {
                errors = response['message'].cast<String>();
              }
            }
          });
        }
      } catch (e, stackTrace) {
        print('Error updating product: $e');
        print(stackTrace);
        // Handle the error gracefully
        setState(() {
          errors = ['Error updating product. Please try again.'];
        });
      } finally {
        setState(() {
          isSelectingAddress = false;
        });
      }
    }

}