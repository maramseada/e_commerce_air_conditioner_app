import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../api/cart_api.dart';
import '../../../../../models/additions_model.dart';
import '../../../../core/constant/colors.dart';

class RadioScreen extends StatefulWidget {
  final int? selectedIndex;
  final void Function(int) onItemSelected;

  RadioScreen({Key? key, required this.onItemSelected, this.selectedIndex}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  String? installingOptions;
  List<AdditionsModel>? data;
  CartApi _api = CartApi();
  int radioIndex = 1; // Nullable to reflect no selection initially

  @override
  void initState() {
    super.initState();
    if (widget.selectedIndex != null) {
      radioIndex = widget.selectedIndex!;
    } // Initialize with selectedIndex
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder(
        future: _api.getAdditions(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            return Container();
          } else {
            data = snapshot.data;
            installingOptions = radioIndex != null ? data![radioIndex! - 1].id.toString() : null;

            return Container(
              height: 110,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        installingOptions = data![index].id.toString();
                        radioIndex = index + 1; // Update radioIndex with the selected index + 1
                        widget.onItemSelected(radioIndex);

                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      decoration: BoxDecoration(
                        color: radioIndex == index + 1 ? Color(0xFFEFF5F9) : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: radioIndex == index + 1 ? Colors.transparent : Color(0xB31D75B1),
                          width: 1.0,
                        ),
                      ),
                      width: size.width * 0.26,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio(
                            value: data![index].id.toString(),
                            groupValue: installingOptions,
                            onChanged: (value) {
                              setState(() {
                                installingOptions = value;
                                radioIndex = index + 1; // Update radioIndex with the selected index + 1
                                widget.onItemSelected(radioIndex); // Notify parent about selection
                              });
                            },
                            activeColor: installingOptions == data![index].id.toString() ? kPrimaryColor : Color(0xff25170B),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: Text(
                              data![index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w700,
                                fontSize: size.width * 0.033,
                                color: installingOptions == data![index].id.toString() ? kPrimaryColor : Color(0xff25170B),
                              ),
                            ),
                          ),
                          Text(
                            data![index].price,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFCA7009),
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
