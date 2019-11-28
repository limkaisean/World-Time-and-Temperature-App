import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{

  //get api key from weather api
  String apiKey = '';
  String location; //location name for the UI
  String time;
  String weather;
  String flag; //url for flag icon
  String url; //location url for api endpoint
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});
  WorldTime.empty();

  Future<void> getTime() async{

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      parseData(response);
      Response response2 = await get('http://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey');
      getWeather(response2);
    }
    catch (e){
      print('caught: $e');
      time = 'your bau sungguh pasti buatku SEMAK';
    }
  }

  Future<void> getTimeByIp() async{

    try {
      Response response = await get('http://worldtimeapi.org/api/ip');
      parseData(response);
      Response response2 = await get('http://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey');
      getWeather(response2);
    }
    catch (e){
      print('caught: $e');
      time = 'your bau sungguh pasti buatku SEMAK';
    }
  }

  void getWeather(Response response){
    dynamic data2 = jsonDecode(response.body);
    int temperature = (data2['main']['temp'] - 273.15).round();
    print(temperature);
    weather = temperature.toString() + '°C';
  }

  void parseData(Response response) {
    Map data = jsonDecode(response.body);

    if (location == null) {
      String timezone = data['timezone'];
      location = timezone.substring(timezone.lastIndexOf('/') + 1);
    }

    //get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    isDayTime = now.hour >= 6 && now.hour <= 19 ? true : false;
    time = DateFormat.jm().format(now);
  }

}