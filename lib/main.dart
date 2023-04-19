import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screen/home/provider/home_provider.dart';
import 'package:weatherapp/screen/home/view/home_screen.dart';
import 'package:weatherapp/screen/moredetails/view/more_screen.dart';
import 'package:weatherapp/screen/second/view/add_screen.dart';
import 'package:weatherapp/screen/splash/view/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => SplashScreen(),
          'home':(context) => HomeScreen(),
          'add':(context) => AddScreen(),
          'more':(context) => MoreScreen(),
        },
      ),
    ),
  );
}
