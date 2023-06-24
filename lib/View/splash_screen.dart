import 'dart:async';

import 'package:covid_tracker_project/View/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _container = AnimationController(
       vsync: this,
      duration: const Duration(seconds: 3))..forward();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
            () { Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStateScreen(),));});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _container.dispose();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _container,
              child: Container(height: 200,
              width:200,
              child: const Center(child: Image(image: AssetImage("assets/images/virus.png"),)),),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: _container.value*2.0*math.pi,
                child: child);
            },),
            const SizedBox(
              height:200),
            const Align(
              alignment: Alignment.center,
              child: Text("Covid-19\nTracker App",textAlign: TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25,
              ),),
            )

      ]),
    );
  }
}









