import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveData(String key, {String? str, int? num, bool? boo}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(str != null){
    prefs.setString(key, str);
  }
  if(num != null){
    prefs.setInt(key, num);
  }
  if(boo != null){
    prefs.setBool(key, boo);
  }
}
Future<String?> getString(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<int?> getInt(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

Future<bool?> getBool(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

Future<void> removeBool(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> removeString(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> removeInt(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
);