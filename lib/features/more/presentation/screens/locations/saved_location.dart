import 'package:e_commerce/features/more/presentation/controllers/Profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/constant/colors.dart';
import '../../components/locations/saved_addresses/saved_addresses_body_bloc.dart';

class SavedLocationScreen extends StatefulWidget {
  const SavedLocationScreen({super.key});

  @override
  State<SavedLocationScreen> createState() => _SavedLocationScreenState();
}

class _SavedLocationScreenState extends State<SavedLocationScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: true, // Set this property to true

          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
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
            title: Column(
              children: [
                Text(
                  'العناوين المحفوظة',
                  style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: size.width * 0.05),
                ),
                SizedBox(
                  height: size.height * 0.012,
                ),
                Text('قائمة العناوين المحفوظة الخاصة بك',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.04,
                      color: grayColor,
                    ))
              ],
            ),
          ),
          body: const SavedAddressesBodyBloc(),
        ));
  }
}
