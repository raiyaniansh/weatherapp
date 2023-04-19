import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/screen/home/modal/home_modal.dart';
import 'package:weatherapp/screen/home/modal/home_modal2.dart';

class ApiHelper {
  HomeModal? homeModal;
  Temperatures? temperatures;
  Future<HomeModal?> CurrentapiCall(String city) async {
    String? link = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=d6a79e618a4e5eb6c4b6f4d09f5983c5';
    Uri uri = Uri.parse(link);
    var response = await http.get(uri);
    var json = jsonDecode(response.body);
    homeModal = HomeModal.fromJson(json);
    return homeModal;
  }

  Future<Temperatures?> WeatherapiCall(String city)
  async {
    String link = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=1177b1e3edcc54bc767e02d9b9806249';
    Uri uri = Uri.parse(link);
    var responce = await http.get(uri);
    var json = jsonDecode(responce.body);
    temperatures = Temperatures.fromJson(json);
    return temperatures;
  }
}
