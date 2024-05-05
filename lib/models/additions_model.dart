class AdditionsModel{

  final int id ;
  final String name ;
  final String price;
  AdditionsModel({
    required this.id, required this.name, required this.price
});
  factory AdditionsModel.fromJson(Map<String, dynamic> jsonData) {
    return AdditionsModel(id: jsonData['id'], name: jsonData['name'], price: jsonData['price']);
  }
}