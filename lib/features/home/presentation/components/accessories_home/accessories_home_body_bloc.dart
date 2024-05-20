import 'package:e_commerce/features/home/presentation/components/accessories_home/accessory_list_view_product.dart';
import 'package:e_commerce/features/home/presentation/controllers/fav_accessory/fav_accessory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/accessor_model.dart';
import '../../../../detailsProduct/presentation/components/accessory_details.dart';
import '../../controllers/Accessories/accessory_cubit.dart';
import '../../controllers/accessory/acessory_details_cubit.dart';

class AccessoriesHomeBodyBloc extends StatelessWidget {
  final   List<AccessoryModel>? products;

  const AccessoriesHomeBodyBloc({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Container(
          color: Colors.white,
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    BlocProvider.of<AccessoryDetailsCubit>(context).getAccessoryDetails(
                      id: products![index].id,
                    );
                    BlocProvider.of<FavAccessoryCubit>(context).isFav(
                      id: products![index].id,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccessoryDetails(
                                  id: products![index].id,
                                ))).then((_) => BlocProvider.of<AccessoryCubit>(context).getAccessoryFav());
                  },
                  child: AccessoryListViewProduct(product: BlocProvider.of<AccessoryCubit>(context).products?[index]));
            },
          )),
    );
  }
}
