class Address {
  final int? id;
   int? areaId;
   int? cityId;
  final String street;
  final String buildingNum;
  final String landmark;
  final AreaModel? area;
  final TownModel? town;
  final CityModel? city;
  final int? townId ;

  Address({
     this.id,
    required this.street,
    required this.buildingNum,
    required this.landmark,
    this.areaId,
    this.cityId,
     this.area,
     this.town,
     this.city,
    this.townId
  });

  factory Address.fromJson(Map<String, dynamic> jsonData) {
    return Address(
      id: jsonData['id'],
      street: jsonData['street'] ?? '',
      buildingNum: jsonData['building_num'] ?? '',
      landmark: jsonData['landmark'] ?? '', // Provide an empty string as default if landmark is null
      area: AreaModel.fromJson(jsonData['area'] ?? {}),
      town: TownModel.fromJson(jsonData['town'] ??{} ),
      city: CityModel.fromJson(jsonData['city'] ?? {}),
      townId:  jsonData['town_id'],
      cityId:  jsonData['city_id'],
      areaId:  jsonData['area_id'],
    );
  }
}

class AreaModel {
  final int? id;
  final String name;

  AreaModel({ this.id, required this.name});

  factory AreaModel.fromJson(Map<String, dynamic> jsonData) {
    return AreaModel(
        id: jsonData['id'],
        name: jsonData['name'] ?? '');
  }
}

class TownModel {
  final int id;
  final String name;
  final int area_id;
  final int city_id;
  TownModel({required this.id, required this.name, required this.area_id, required this.city_id});

  factory TownModel.fromJson(Map<String, dynamic> jsonData) {
    return TownModel
      (
        id: jsonData['id']??1,
        name: jsonData['name' ]?? '',
        area_id: jsonData['area_id']?? 1,
        city_id: jsonData['city_id']?? 1);
  }
}

class CityModel {
  final int id;
  final String name;
  final int area_id;
  CityModel({
    required this.id,
    required this.name,
    required this.area_id,
  });

  factory CityModel.fromJson(Map<String, dynamic> jsonData) {
    return CityModel(id: jsonData['id']?? 1, name: jsonData['name'] ?? '', area_id: jsonData['area_id']?? 1);
  }
}