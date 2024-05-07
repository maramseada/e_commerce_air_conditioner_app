import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Cubits/Images/image_cubit.dart';
import '../../../../../Cubits/Images/image_state.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;

  const ImageLoader({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ImagesCubit>(context).getImage(image: imageUrl);

    return BlocBuilder<ImagesCubit, ImagesState>(
      builder: (context, state) {
        if (state is ImagesLoading) {
          return Container();
        } else if (state is ImagesSuccess) {
          return Container(
            alignment: Alignment.center,
            child: state.imageWidget,
          );
        } else if (state is ImagesFailure) {
          return Container();
        } else {
          return Container();
        }},

    );
  }
}
