import 'package:flutter/material.dart';

import '../../../../widgets/floating_button_ask_price.dart';
import '../components/best_sellers/best_sellers_body_bloc.dart';


class ShowBestSellers extends StatefulWidget {
  final String productName;
  const ShowBestSellers({super.key, required this.productName});

  @override
  State<ShowBestSellers> createState() => _ShowBestSellersState();
}


class _ShowBestSellersState extends State<ShowBestSellers> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            widget.productName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(
            color: Colors.blue,
          ),
        ),
        body: const BestSellersBodyBloc(),
        floatingActionButton: const AskPriceFloatingButton(),
      ),
    );
  }
}

