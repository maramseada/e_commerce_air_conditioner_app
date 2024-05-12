import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import 'image_state.dart';
//
// class ImagesCubit extends Cubit<ImagesState> {
//   final Api api;
//   bool _isClosed = false;
//
//   ImagesCubit(this.api) : super(ImagesInitial());
//
//   // Method to fetch image
//   Future<void> getImage({required String image}) async {
//     if (_isClosed) return; // Check if cubit is closed
//     try {
//       emit(ImagesLoading()); // Emit loading state
//       final imageWidget = await api.getImage(image); // Fetch image from API
//       if (_isClosed) return; // Check if cubit is closed
//       if (imageWidget != null) {
//         emit(ImagesSuccess(imageWidget)); // Emit success state with image
//       } else {
//         emit(ImagesFailure(errMessage: 'Image not found')); // Emit failure state if image is null
//       }
//     } catch (e) {
//       if (_isClosed) return; // Check if cubit is closed
//       emit(ImagesFailure(errMessage: 'Error: $e')); // Emit failure state if an error occurs
//     }
//   }
//
//   // Override close method to handle closure
//   @override
//   Future<void> close() {
//     _isClosed = true; // Mark cubit as closed
//     return super.close(); // Call super method to close the cubit
//   }
// }
