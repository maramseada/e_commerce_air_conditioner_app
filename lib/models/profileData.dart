class profileData {

  final String f_name;
  final String l_name;
  final String email;
  final String phone;
  final List? addresses;

  profileData({

    required this.f_name,
    required this.l_name,
    required this.email,
    required this.phone,
     this.addresses
  });

  factory profileData.fromJson(Map<String, dynamic> json) {
    return profileData(

      f_name: json['f_name'],
      l_name: json['l_name'],
      email: json['email'],
      phone: json['phone'],
      addresses: json['addresses']??[],
    );
  }
}