import 'dart:math';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screen/home/modal/home_modal.dart';
import 'package:weatherapp/screen/home/modal/home_modal2.dart';
import 'package:weatherapp/screen/home/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? homeProviderf;
  HomeProvider? homeProvidert;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).addCity();
  }

  @override
  Widget build(BuildContext context) {
    homeProviderf = Provider.of<HomeProvider>(context, listen: false);
    homeProvidert = Provider.of<HomeProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: SwipeDetector(
          onSwipeLeft: (offset) {
            homeProviderf!.chindex('left');
          },
          onSwipeRight: (offset) {
            homeProviderf!.chindex('right');
          },
          child: Stack(
            children: [
              Container(
                height: 805,
                width: double.infinity,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        transform: GradientRotation(pi / 2.4),
                        colors: [Colors.blue.shade900, Colors.blue.shade600])),
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      child: FutureBuilder(
                        future: homeProviderf!.JsonParse(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else if (snapshot.hasData) {
                            HomeModal? home = snapshot.data;
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        '${home!.name}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: homeProviderf!.city
                                            .asMap()
                                            .entries
                                            .map((e) => Container(
                                                  height: 10,
                                                  width: 10,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 2),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: (e.key ==
                                                              homeProvidert!
                                                                  .index)
                                                          ? Colors.white
                                                          : Colors.white54),
                                                ))
                                            .toList(),
                                      ),
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text(
                                              "${(home.main!.temp! - 273).toInt()}",
                                              style: TextStyle(
                                                  fontSize: 125,
                                                  color: Colors.white)),
                                          Text("°c",
                                              style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Text(
                                          "${home.weather![0].main} ${(home.main!.tempMin! - 273).toInt()}°/ ${(home.main!.tempMax! - 273).toInt()}°",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 325,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 50),
                                      height: 425,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Today",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "Weather                       : ${home.weather![0].main}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                                Text(
                                                    "Weather Description : ${home.weather![0].description}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                                Text(
                                                    "Visibility                      : ${home.visibility}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                                Text(
                                                    "Wind speed                 : ${home.wind!.speed}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                                Text(
                                                    "Wind degree               : ${home.wind!.deg}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                                Text(
                                                    "Country                       : ${home.sys!.country}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                              ],
                                            ),
                                          ),
                                          FutureBuilder(
                                            future:
                                                homeProviderf!.WeatherParse(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    '${snapshot.error}');
                                              } else if (snapshot.hasData) {
                                                Temperatures? tem =
                                                    snapshot.data;
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "5 - day forecast",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                              Expanded(child: SizedBox()),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pushNamed(context, 'more');
                                                                },
                                                                child: Text(
                                                                  "More details",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "${DateFormat('EEEE').format(homeProviderf!.date1)}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    "${(tem!.list![0].dtTxt).toString().substring(0, 10)}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "Min temp  : ",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            "${(tem.list![0].main!.tempMin! - 273).toString().substring(0, 4)}°",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "Max temp : ",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            "${(tem!.list![0].main!.tempMax! - 273).toString().substring(0, 4)}°",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "pressure   : ",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            "${(tem.list![0].main!.pressure).toString()}",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "${DateFormat('EEEE').format(homeProviderf!.date2)}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  Text(
                                                                    "${(tem.list![5].dtTxt).toString().substring(0, 10)}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "Min temp  : ",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            "${(tem.list![5].main!.tempMin! - 273).toString().substring(0, 4)}°",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "Max temp : ",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            "${(tem.list![5].main!.tempMax! - 273).toString().substring(0, 4)}°",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "pressure   : ",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                        Text(
                                                                            "${(tem.list![5].main!.pressure).toString()}",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                              return Container(height: 202,alignment: Alignment.center,child: Container(height: 100,child: Lottie.asset('assets/json/loading.json')));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child: Icon(
                                          Icons.menu,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'WeatherMan',
                                        style: GoogleFonts.permanentMarker(color: Colors.white,fontSize: 25)
                                      ),
                                      InkWell(
                                          onTap: () {
                                            homeProviderf!.cityicon = false;
                                            Navigator.pushNamed(context, 'add');
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container(height: double.infinity,width: double.infinity,color: Colors.white54,alignment: Alignment.center,child: Container(height: 100,child: Lottie.asset('assets/json/loading.json')));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Added city",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: homeProviderf!.city.length,
                    itemBuilder: (context, index) => FutureBuilder(
                      future: homeProviderf!.DJsonParse(index),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.hasData) {
                          HomeModal? home = snapshot.data;
                          return InkWell(
                            onTap: () {
                              homeProviderf!.changeindeD(
                                  index);
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 2, right: 2, top: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${home!.name}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text("${(home.main!.temp! - 273).toInt()}",
                                          style: TextStyle(
                                              fontSize: 35, color: Colors.white)),
                                      Text("°c",
                                          style: TextStyle(
                                              fontSize: 25, color: Colors.white)),
                                    ],
                                  ),
                                  Text(
                                      "${home.weather![0].main} ${(home.main!.tempMin! - 273).toInt()}°/ ${(home.main!.tempMax! - 273).toInt()}°",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 18)),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container(height: 70,margin: const EdgeInsets.only(left: 2, right: 2, top: 10),width: double.infinity,decoration: BoxDecoration(color: Colors.grey.shade800,borderRadius: BorderRadius.circular(10)),alignment: Alignment.center,child: Container(height: 100,child: Lottie.asset('assets/json/loading.json')));

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
