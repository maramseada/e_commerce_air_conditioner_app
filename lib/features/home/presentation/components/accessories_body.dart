import 'package:e_commerce/features/home/presentation/controllers/fav_accessory/fav_accessory_cubit.dart';
import 'package:e_commerce/widgets/add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../api/api.dart';
import '../../../../constant/colors.dart';
import '../../../../models/accessor_model.dart';
import '../../../screens/detailsProduct/presentation/components/accessory_details.dart';
import '../controllers/accessory/acessory_details_cubit.dart';
import 'accessories_product.dart';

class AccessoriesBody extends StatefulWidget {
  final List<AccessoryModel>? products;

  const AccessoriesBody({Key? key, required this.products}) : super(key: key);

  @override
  State<AccessoriesBody> createState() => _AccessoriesBodyState();
}

class _AccessoriesBodyState extends State<AccessoriesBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),

        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right:10, top: size.height * 0.01),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.66,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,
                ),
                itemCount: widget.products!.length,
                // Set the number of items in the grid
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<AccessoryDetailsCubit>(context).getAccessoryDetails(
                        id: widget.products![index].id,
                      );
                      BlocProvider.of<FavAccessoryCubit>(context).isFav(
                        id: widget.products![index].id,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccessoryDetails(
                            id: widget.products![index].id,
                          ),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: AccessoriesProduct(product: widget.products![index]),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }


}
