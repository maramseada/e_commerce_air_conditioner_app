import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/constant/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/ordermodel.dart';
import '../../components/my_orders/order_details_bloc.dart';
import '../../controllers/orders_cubit/orders_cubit.dart';

class OrderDetails extends StatefulWidget {
 final int id;
  const OrderDetails({super.key, required this.id});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

//ordersDetails
class _OrderDetailsState extends State<OrderDetails> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool inProgress = false;
  double? ratingProduct;
  int? rateInt;
  String? comment;
  String? accessoryComment;
  List<TextEditingController> ratingControllers = [];
  List<TextEditingController> ratingControllersAdds = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  OrderModel? order;

  String? accessoryId;
  String? orderId;
  @override
  void initState() {
    super.initState();


    BlocProvider.of<OrdersCubit>(context).getOrderDetails(id: widget.id);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
          ),
          title: Text(
            'تفاصيل الطلب',
            style: TextStyle(fontFamily: 'Almarai', fontWeight: FontWeight.w900, fontSize: getResponsiveFontSize(context, fontSize: 20)),
          ),
        ),
        body: const OrderDetailsBloc(),
      ),
    );
  }

  // void addReview(
  //   int index,
  // ) async {
  //   setState(() {
  //     progress = true;
  //     comment = ratingControllers[index].text;
  //
  //   });
  //   print('orderrrrrrrrrrrrriddddddddddd$orderId');
  //   print('orderrrrrrrrrrrrriddddddddddd$comment');
  //   print('orderrrrrrrrrrrrriddddddddddd$ratingProduct');
  //   print('orderrrrrrrrrrrrriddddddddddd$accessoryComment');
  //   try {
  //     String reviewComment = '';
  //     String reviewCommentAccessory = '';
  //
  //     // Concatenate comments from both fields
  //     // if (comment != null && comment!.isNotEmpty) {
  //     //   reviewComment += comment! + ' '; // Add comment from product field
  //     // }
  //     // if (accessoryComment != null && accessoryComment!.isNotEmpty) {
  //     //   reviewCommentAccessory += accessoryComment!; // Add comment from accessory field
  //     // }
  //
  //     Map<String, dynamic>? response = await _api.addReview(
  //       comment?? '', // Trim to remove any leading/trailing spaces
  //       rateInt == null || rateInt == 0.0 ? '3' : rateInt.toString(),
  //       orderId ?? '',
  //      '',
  //     );
  //
  //
  //
  //     if (response != null && response['status'] == 200) {
  //       SnackBar snackBar = SnackBar(
  //         content: Text(
  //           'Review Added Successfully',
  //           style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
  //         ),
  //         backgroundColor: Colors.white,
  //       );
  //
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       print('Review added');
  //       ratingControllers[index].text = '';
  //     } else {
  //       if (response != null && response['message'] != null) {
  //         setState(() {
  //           if (response['message'] is String) {
  //             errors = [response['message']];
  //           } else if (response['message'] is List<dynamic>) {
  //             errors = response['message'].cast<String>();
  //           }
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print('Network Error: $e');
  //     setState(() {
  //       errors = ['Network error occurred. Please check your connection.'];
  //     });
  //   } finally {
  //     setState(() {
  //       progress = false;
  //     });
  //   }
  // }
  //
  // void addReviewExtra( int index) async {
  //   setState(() {
  //     progress = true;
  //     accessoryComment = ratingControllersAdds[index].text; // Retrieve text from the appropriate controller
  //   });
  //   print('accessory id=========== $accessoryId');
  //   print('accessory  comment=======$accessoryComment');
  //   print('accessory rating ===========$ratingProduct');
  //
  //   try {
  //     Map<String, dynamic>? response = await _api.addReview(
  //       accessoryComment ?? '',
  //       rateInt == null || rateInt == 0.0 ? '3' : rateInt.toString(),
  //       '',accessoryId?? '',
  //     );
  //
  //     if (response != null && response['status'] == 200) {
  //       SnackBar snackBar = SnackBar(
  //         content: Text(
  //           'Review Added Successfully',
  //           style: TextStyle(color: kPrimaryColor, fontSize: 16, fontFamily: 'Almarai', fontWeight: FontWeight.w700),
  //         ),
  //         backgroundColor: Colors.white,
  //       );
  //
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       print('Review added accessoryy ');
  //       ratingControllersAdds[index].text = '';
  //     } else {
  //       if (response != null && response['message'] != null) {
  //         setState(() {
  //           if (response['message'] is String) {
  //             errors = [response['message']];
  //           } else if (response['message'] is List<dynamic>) {
  //             errors = response['message'].cast<String>();
  //           }
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print('Network Error: $e');
  //     setState(() {
  //       errors = ['Network error occurred. Please check your connection.'];
  //     });
  //   } finally {
  //     setState(() {
  //       progress = false;
  //     });
  //   }
  // }

}
