import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacementNamed(context, 'home');
    });
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 300,),
              Container(width: 300,child: Image.asset('assets/images/logopng.png',color: Colors.blueGrey)),
              SizedBox(height: 200,),
              Text("WeatherMan",style: GoogleFonts.permanentMarker(color: Colors.blueGrey,fontSize: 33),),
              SizedBox(height: 10,),
              Container(height: 100,child: Lottie.asset('assets/json/loading.json')),
            ],
          ),
        ),
      ),
    );
  }
}
