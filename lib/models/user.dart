class User {
  final int? id;
  final String f_name;
  final String l_name;
  final String phone;
  final String password;
  final String password_confirmation;
  final String email;
  final String otp;

  User({
    this.id,
    required this.f_name,
    required this.l_name,
    required this.phone,
    required this.password,
    required this.password_confirmation,
    required this.email,
    required this.otp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      f_name: json['f_name']??'',
      l_name: json['l_name']?? '',
      phone: json['phone']?? '',
      password: json['password']?? '',
      password_confirmation: json['password_confirmation']??'',
      email: json['email']??'',
      otp: json['otp']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'f_name': f_name,
      'l_name': l_name,
      'phone': phone,
      'password': password,
      'password_confirmation': password_confirmation,
      'email': email,
      'otp': otp,
    };
  }
}
