import 'package:e_commerce/features/more/presentation/controllers/locations_cubit/locations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constant/colors.dart';

import 'delete_address_button.dart';

class DeleteAddress extends StatelessWidget {
  final int id;
  const DeleteAddress({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
          height: size.height * 0.4,
          decoration: const BoxDecoration(
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
                        onTap: () {
                          BlocProvider.of<LocationsCubit>(context).deleteAddress(id: id);
                        },
                        child: const DeleteAddressButton())),
              ],
            ),
          )),
    );
  }
}
