import 'package:flutter/material.dart';
import 'package:myapp/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void getWorldTime() async {
    WorldTime datetime = WorldTime.empty();
    await datetime.getTimeByIp();
    await Future.delayed(Duration(seconds: 1), (){});
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': datetime.location,
      'flag': datetime.flag,
      'time': datetime.time,
      'isDayTime': datetime.isDayTime,
      'weather': datetime.weather,
    });
  }

  @override
  void initState() {
    super.initState();
    getWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child:(
          SpinKitWanderingCubes(
            color: Colors.white,
            size: 50.0,
          )
        ),
      ),
    );
  }
}
