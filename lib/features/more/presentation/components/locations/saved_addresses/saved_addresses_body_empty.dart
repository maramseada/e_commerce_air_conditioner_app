import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constant/colors.dart';
import '../../../../../../core/constant/navigator.dart';
import '../../../../../../widgets/button.dart';

import '../../../controllers/locations_cubit/locations_cubit.dart';
import '../../../screens/locations/add_address.dart';

class SavedAddressesBodyEmpty extends StatefulWidget {
  const SavedAddressesBodyEmpty({super.key});

  @override
  State<SavedAddressesBodyEmpty> createState() => _SavedAddressesBodyEmptyState();
}

class _SavedAddressesBodyEmptyState extends State<SavedAddressesBodyEmpty> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.16,
          ),
          SvgPicture.asset('assets/images/Group 176180.svg'),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: size.width * 0.34,
            child: Text(
              'لا توجد لديك عناوين محفوظة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.04,
                color: grayColor,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {                    BlocProvider.of<LocationsCubit>(context).getAreas();


              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddAddressScreen())).then((_) => setState(() {}));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 20),
                child: const Button(
                  text: 'إضافة عنوان جديد',
                ),
              ))
        ],
      ),
    );
  }
}
