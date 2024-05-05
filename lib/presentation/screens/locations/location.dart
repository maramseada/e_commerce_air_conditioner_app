import 'package:e_commerce/constant/colors.dart';
import 'package:e_commerce/constant/navigator.dart';
import 'package:e_commerce/presentation/screens/locations/saved_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/address_api.dart';
import '../../../models/address.dart';
import '../../../utilities/shared_pref.dart';
import 'edit_address.dart';

class locationWidget extends StatefulWidget {
  Address address;
  locationWidget({super.key, required this.address});

  @override
  State<locationWidget> createState() => _locationWidgetState();
}

class _locationWidgetState extends State<locationWidget> {
  final _formKey = GlobalKey<FormState>();
  ApiAddress _api = ApiAddress();
  List<String> errors = [];
  bool delete = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 180,
          margin: EdgeInsets.only(left: size.width * 0.04, right: size.width * 0.04, top: 20),
          decoration: BoxDecoration(
            color: paleGrayColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      right: size.width * 0.045,
                      top: size.height * 0.025,
                    ),
                    child: SvgPicture.asset('assets/images/locationicon.svg'),
                  ),
                  Container(
                    height: 115,
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${widget.address.area!.name}',
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w600, fontSize: size.width * 0.035, color: Colors.black),
                            ),
                            Text('  , '),
                            Text(
                              '${widget.address.city!.name}',
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w600, fontSize: size.width * 0.035, color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.address.town!.name}',
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w500, fontSize: size.width * 0.035, color: Colors.black),
                            ),
                            Text('  , '),
                            Text(
                              widget.address.buildingNum,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w500, fontSize: size.width * 0.035, color: Colors.black),
                            ),
                            Text('  , '),
                            Text(
                              widget.address.street,
                              style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w500, fontSize: size.width * 0.035, color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          widget.address.landmark,
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontWeight: FontWeight.w400,
                            color: grayColor,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          EditAddress(
                            address: widget.address,
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: size.width * 0.7,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Color(0xFFe1eaf0)),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/edit-2.svg',
                            width: 22,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'تعديل العنوان',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _showBottomSheet(),
                    child: SvgPicture.asset(
                      'assets/images/pinktrash.svg',
                      width: 30,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  void deleteAddress() async {
    setState(() {
      delete = true;
    });

    try {
      Map<String, dynamic>? response =
      await _api.deleteAddress(widget.address.id!.toString());

      if (response != null && response['status'] == 200) {
        Navigator.pop(context);
        print('Delete Address: Deletion success');
        setState(() {

        });
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
        delete = false;
      });
    }
  }

  Future<void> _showBottomSheet() async {
    Size size = MediaQuery.of(context).size;

    // Display your bottom sheet here

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.08, bottom: size.height * 0.01),
                      child: SvgPicture.asset(
                        'assets/images/bold.svg',
                        height: size.height * 0.05,
                      ),
                    ),
                    Text(
                      'حذف العنوان ',
                      style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.bold, fontSize: size.width * 0.04, color: redColor),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: size.height * 0.007,
                      ),
                      width: size.width * 0.6,
                      child: Text(
                        'هل أنت متأكد من حذف هذا العنوان ؟',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Almarai', fontSize: size.width * 0.035, color: grayColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.035,
                        right: size.width * 0.04,
                        left: size.width * 0.04,
                      ),
                      child: InkWell(
                          onTap: delete ? null : deleteAddress,
                          child: delete
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                    strokeWidth: 2,
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: size.height * 0.08,
                                  decoration: ShapeDecoration(
                                    color: delete ? redColor : redColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
                                  ),
                                  child: Center(
                                    child: delete
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'تأكيد حذف العنوان',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 0.05,
                                              fontFamily: 'Almarai',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                )),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

}
