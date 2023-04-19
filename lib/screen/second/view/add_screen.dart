import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/screen/home/modal/home_modal.dart';
import 'package:weatherapp/screen/home/provider/home_provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  HomeProvider? homeProviderf;
  HomeProvider? homeProvidert;
  @override
  Widget build(BuildContext context) {
    homeProviderf = Provider.of<HomeProvider>(context, listen: false);
    homeProvidert = Provider.of<HomeProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: 820,
                width: double.infinity,
                alignment: Alignment.topCenter,
                color: Colors.black,
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      child: FutureBuilder(
                        future: homeProviderf!.JsonSearchParse(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else if(snapshot.hasData) {
                            HomeModal? home = snapshot.data;
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 10,),
                                        AnimatedContainer(
                                            duration: Duration(seconds: 2),
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: (homeProvidert!.i == true)
                                                ? 250
                                                : 140,
                                            curve: Curves.ease,
                                            child: (homeProviderf!.i == true)
                                                ? TextField(
                                              controller: homeProviderf!.txtcity,
                                              cursorColor: Colors.white,
                                              decoration: InputDecoration(hintText: 'Search for city',hintStyle: TextStyle(color: Colors.white70),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
                                              style: TextStyle(color: Colors.white,fontSize: 20,),
                                            )
                                                : Text('WeatherMan',style: GoogleFonts.permanentMarker(color: Colors.white,fontSize: 25),)),
                                        InkWell(
                                            onTap: () {
                                              homeProviderf!.JsonSearchParse();
                                              homeProviderf!.ChangeI();
                                            },
                                            child: Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Text('${home!.name}',style: TextStyle(color: Colors.white,fontSize: 30,),),
                                    SizedBox(height: 100,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 40,),
                                        Text("${(home.main!.temp! - 273).toInt()}",style: TextStyle(fontSize: 125,color: Colors.white)),
                                        Text("°c",style: TextStyle(fontSize: 50,color: Colors.white)),
                                      ],
                                    ),
                                    Text("${home.weather![0].main} ${(home.main!.feelsLike! - 273).toInt()}°/ ${(home.main!.tempMax! - 273).toInt()}°",style: TextStyle(color: Colors.white70,fontSize: 20)),
                                    SizedBox(height: 200,),
                                    (homeProvidert!.cityicon)?FloatingActionButton(onPressed: () {
                                      Navigator.pop(context);
                                    },child: Icon(Icons.navigate_next,color: Colors.white,size: 40,),backgroundColor: Colors.grey.shade800,):FloatingActionButton(onPressed: () {
                                      homeProviderf!.addCity();
                                    },child: Icon(Icons.add,color: Colors.white,size: 40),backgroundColor: Colors.grey.shade800,),
                                    SizedBox(height: 8,),
                                    Text('Add to start page',style: TextStyle(color: Colors.white70),),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container(height: double.infinity,width: double.infinity,color: Colors.white70,alignment: Alignment.center,child: Container(height: 100,child: Lottie.asset('assets/json/loading.json')));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
