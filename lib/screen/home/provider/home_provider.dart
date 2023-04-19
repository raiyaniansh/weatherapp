import 'package:flutter/material.dart';
import 'package:weatherapp/screen/home/modal/home_modal.dart';
import 'package:weatherapp/screen/home/modal/home_modal2.dart';
import 'package:weatherapp/utils/api_helper.dart';

class HomeProvider extends ChangeNotifier
{
  ApiHelper api = ApiHelper();
  bool i = false;

  TextEditingController txtcity = TextEditingController(text: 'surat');
  DateTime date = DateTime.now();
  DateTime date1 = DateTime.now().add(Duration(days: 1));
  DateTime date2 = DateTime.now().add(Duration(days: 2));
  DateTime date3 = DateTime.now().add(Duration(days: 3));
  DateTime date4 = DateTime.now().add(Duration(days: 4));
  DateTime date5 = DateTime.now().add(Duration(days: 5));


  int index = 0;
  List city = [];
  bool cityicon = false;

  void chindex(String swip)
  {
    if(swip=='left')
      {
        if(index<city.length-1)
          {
            index++;
            notifyListeners();
          }
      }
    else if(swip=='right')
      {
        if(index>0)
          {
            index--;
            notifyListeners();
          }
      }
  }

  void changeindeD(int ind)
  {
    index=ind;
    notifyListeners();
  }

  void addCity()
  {
    city.add(txtcity.text);
    var a1= Set();
    List list= city.where((element) => a1.add(element)).toList();
    city=list;
    cityicon=true;
    notifyListeners();
  }
  void ChangeI()
  {
    i=!i;
    notifyListeners();
  }

  Future<HomeModal?> JsonParse()
  async {
    HomeModal? homeModal =await api.CurrentapiCall(city[index]);
    return homeModal;
  }

  Future<HomeModal?> DJsonParse(int index)
  async {
    HomeModal? homeModal =await api.CurrentapiCall(city[index]);
    return homeModal;
  }

  Future<Temperatures?> WeatherParse()
  async {
    Temperatures? temperatures = await api.WeatherapiCall(city[index]);
    return temperatures;
  }

  Future<HomeModal?> JsonSearchParse()
  async {
    HomeModal? homeModal =await api.CurrentapiCall(txtcity.text);
    return homeModal;
  }

}