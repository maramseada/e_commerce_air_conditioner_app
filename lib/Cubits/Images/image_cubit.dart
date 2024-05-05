import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import 'image_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  final Api api;
  Widget? imageWidget;
  String? image;

  ImagesCubit(this.api) : super(ImagesInitial());

  // Method to fetch image
  Future<void> getImage({required String image}) async {
    try {
      emit(ImagesLoading()); // Emit loading state
      imageWidget = await api.getImage(image); // Fetch image from API
      if (imageWidget != null) {
        emit(ImagesSuccess(imageWidget!)); // Emit success state with image
      } else {
        emit(ImagesFailure(errMessage: 'Image not found')); // Emit failure state if image is null
      }
    } catch (e) {
      emit(ImagesFailure(errMessage: 'Error: $e')); // Emit failure state if an error occurs
    }
  }

  // Override close method to handle closure
  @override
  Future<void> close() {
    imageWidget = null; // Clear imageWidget reference
    return super.close(); // Call super method to close the cubit
  }
}