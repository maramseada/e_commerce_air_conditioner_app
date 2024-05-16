import 'package:flutter/material.dart';

import '../../../../../../models/address.dart';
import '../location.dart';

class SavedAddressesBody extends StatelessWidget {
  final     List<Address> addresses;
  const SavedAddressesBody({super.key, required this.addresses});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(
              addresses.length,
                  (index) => LocationWidget(address: addresses[index]),
            )),
      ),
    );
  }
}
