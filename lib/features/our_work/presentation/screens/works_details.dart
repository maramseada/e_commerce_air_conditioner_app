import 'package:flutter/material.dart';
import '../../../../../core/constant/colors.dart';
import '../components/work_details/work_details_bloc.dart';

class WorksDetails extends StatelessWidget {
  const WorksDetails({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text(
                'أعمال الــ $type',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w800,
                  fontSize: size.width * 0.05,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'تعرف على أعمال تمديدات الهواء التي نقدمها',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.04,
                  color: grayColor,
                ),
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
          ),
        ),
        body: const WorkDetailsBloc(),
      ),
    );
  }
}
