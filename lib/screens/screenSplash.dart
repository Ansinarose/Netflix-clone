import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/widgets/bottomNav.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash ({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Timer(const Duration(seconds: 3), () {
   Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => const BottomNavBar() ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
       body: Center(
         child: Lottie.asset("assets/netflix.json"),
       ),
    
     
    );
  }
}