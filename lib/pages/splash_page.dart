import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertravelwild/pages/Login_page.dart';
import 'package:fluttertravelwild/pages/home_page.dart';
import 'package:fluttertravelwild/pages/profile_page.dart';

class Splash extends StatefulWidget {
  // const Splash({super.key});
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _closeSplash();
    super.initState();
  }
  // Future<void> _closeSplash() async {
  //   Future.delayed(const Duration(seconds: 3), () async {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => LoginPage()));
  //   });
  // }

  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async {
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
            child: Center(
              // child: Image(image: AssetImage('assets/img/baggage.png')),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/img/baggage.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  // Text("WildTravel",
                  // style:TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 30,color: Colors.cyan))
                ],
              ),
            )));
  }
}
