class Coupon {
  final int id;
  final String code;
  final int percent;
  final String startDate;
  final String endDate;
  final String maxValue;
  final int timesUse;
  final int offerType;

  Coupon({
    required this.id,
    required this.code,
    required this.percent,
    required this.startDate,
    required this.endDate,
    required this.maxValue,
    required this.timesUse,
    required this.offerType,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      percent: json['percent'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      maxValue: json['max_value'],
      timesUse: json['times_use'],
      offerType: json['offer_type'],
    );
  }
}

class CartDetails {
  final int id;
  final int userId;
  final String total;
  final String discountValue;
  final String addedValue;
   int? promoCodeId;
  final String grandTotal;
  final int addressId;

  CartDetails({
    required this.id,
    required this.userId,
    required this.total,
    required this.discountValue,
    required this.addedValue,
     this.promoCodeId,
    required this.grandTotal,
    required this.addressId,

  });

  factory CartDetails.fromJson(Map<String, dynamic> json) {
    return CartDetails(
      id: json['id'],
      userId: json['user_id'],
      total: json['total'],
      discountValue: json['discount_value'],
      addedValue: json['added_value'],
      promoCodeId: json['promo_code_id'],
      grandTotal: _parseDynamicToString(json['grand_total']), // Handle string or integer
      addressId: json['address_id'],

    );
  }

  static String _parseDynamicToString(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is int) {
      return value.toString();
    } else {
      throw FormatException('Invalid format for grandTotal: $value');
    }
  }
}

class CartData {
  final Coupon coupon;
  final CartDetails cart;
  final String tax;

  CartData({
    required this.coupon,
    required this.cart,
    required this.tax,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      coupon: Coupon.fromJson(json['coupon']),
      cart: CartDetails.fromJson(json['cart']),
      tax: json['tax'],
    );
  }
}

