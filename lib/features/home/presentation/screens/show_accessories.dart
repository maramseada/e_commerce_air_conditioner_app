import 'package:e_commerce/features/home/presentation/controllers/fav_accessory/fav_accessory_cubit.dart';
import 'package:e_commerce/widgets/floating_button_ask_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/accessor_model.dart';
import '../components/accessories_body.dart';
import '../controllers/Accessories/accessory_cubit.dart';
import '../controllers/Accessories/accessory_state.dart';

class ShowMoreAccessories extends StatefulWidget {
  final String productName;
  const ShowMoreAccessories({super.key, required this.productName});

  @override
  State<ShowMoreAccessories> createState() => _ShowMoreAccessoriesState();
}

class _ShowMoreAccessoriesState extends State<ShowMoreAccessories> {
  List<AccessoryModel>? products;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
            textDirection: TextDirection.rtl,
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Scaffold(
                  backgroundColor: Colors.white,
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
                  body: BlocConsumer<AccessoryCubit, AccessoryState>(
                    builder: (BuildContext context, state) {
                      if (state is AccessoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is AccessorySuccess) {
                        products = BlocProvider.of<AccessoryCubit>(context).products;
                        BlocProvider.of<FavAccessoryCubit>(context).loadInitialData();

                        return AccessoriesBody(
                          products: products,
                        );
                      } else {
                        return const Center(child: Text('يوجد مشكلة في الاتصال بالانترنت '));
                      }
                    },
                    listener: (BuildContext context, AccessoryState state) {
                      if (state is AccessorySuccess) {
                        products = BlocProvider.of<AccessoryCubit>(context).products;
                      }
                    },
                  ),
                  floatingActionButton: AskPriceFloatingButton()),
            )),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
//      SnackBar snackBar = SnackBar(
//         content: Text(response!['message'], style: TextStyle(
//             color:kPrimaryColor,
//             fontSize:16,
//             fontFamily: 'Almarai',
//             fontWeight: FontWeight.w700
//
//         ),),
//         backgroundColor: Colors.white, // Set your desired background color here
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
