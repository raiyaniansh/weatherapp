import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/screen/home/modal/home_modal2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screen/home/provider/home_provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  HomeProvider? homeProviderf;
  HomeProvider? homeProvidert;

  @override
  Widget build(BuildContext context) {
    homeProviderf = Provider.of<HomeProvider>(context, listen: false);
    homeProvidert = Provider.of<HomeProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: 805,
            width: double.infinity,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                transform: GradientRotation(pi / 2.4),
                colors: [Colors.blue.shade900, Colors.blue.shade600],
              ),
            ),
            child: FutureBuilder(
              future: homeProviderf!.WeatherParse(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  Temperatures? tem = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              InkWell(onTap: () {
                                Navigator.pop(context);
                              },child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
                              SizedBox(width: 80,),
                              Column(
                                children: [
                                  Text('Weatherman',
                                      style: GoogleFonts.permanentMarker(color: Colors.white,fontSize: 25)),
                                  Text('${tem!.city!.name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "5 - day forecast by hourly",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 689,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          height: 171,
                                          margin: EdgeInsets.only(top: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.white12,
                                              borderRadius: BorderRadius.circular(20),),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(width: double.infinity,height: 28,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white30,borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),child: Text("${(tem.list![index].dtTxt).toString().substring(0, 19)}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20))),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Avrage Tem : ${(tem.list![index].main!.temp)} k",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20)),
                                                    Text("Minimum Tem : ${(tem.list![index].main!.tempMin)} k",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20)),
                                                    Text("Meximum Tem : ${(tem.list![index].main!.tempMax)} k",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20)),
                                                    Text("Weather : ${(tem.list![index].weather![0].main)} ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20)),
                                                    Text("visibility : ${(tem.list![index].visibility)} ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20)),
                                                    Text("Wind speed : ${(tem.list![index].wind!.speed)} ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20)),
                                                    Text("Wind degree : ${(tem.list![index].wind!.deg)} ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: tem.list!.length,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container(height: double.infinity,width: double.infinity,color: Colors.white54,alignment: Alignment.center,child: Container(height: 100,child: Lottie.asset('assets/json/loading.json')));
              },
            )),
      ),
    );
  }
}
