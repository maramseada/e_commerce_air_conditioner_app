import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../models/address.dart';
import '../../controllers/Profile/profile_cubit.dart';
import '../../screens/locations/edit_address.dart';

class LocationWidget extends StatefulWidget {
  final Address address;
  const LocationWidget({super.key, required this.address});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
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
                            widget.address.area!.name,
                            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w600, fontSize: size.width * 0.035, color: Colors.black),
                          ),
                          const Text('  , '),
                          Text(
                            widget.address.city!.name,
                            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w600, fontSize: size.width * 0.035, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.address.town!.name,
                            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w500, fontSize: size.width * 0.035, color: Colors.black),
                          ),
                          const Text('  , '),
                          Text(
                            widget.address.buildingNum,
                            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w500, fontSize: size.width * 0.035, color: Colors.black),
                          ),
                          const Text('  , '),
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
                    BlocProvider.of<LocationsCubit>(context).getAreas();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>   EditAddress(
                          address: widget.address,
                        )
                      ),


                    ).then((_) => BlocProvider.of<ProfileCubit>(context).getProfileData());
                  },
                  child: Container(
                    height: 50,
                    width: size.width * 0.7,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: const Color(0xFFe1eaf0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/edit-2.svg',
                          width: 22,
                        ),
                        const SizedBox(
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
                  onTap: () {
                    BlocProvider.of<LocationsCubit>(context).showBottomSheet(context: context, id: widget.address.id!);
                  },
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
    );
  }
}
