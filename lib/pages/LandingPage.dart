import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertravelwild/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/Place.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

    void _setPlace(Place place) async {
    //  local store
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("place", jsonEncode(place));
    print("SavePlace");
    String json = jsonEncode(place);
  }


  void createPlace(){

    var place = Place( "", "guatape", "medellin", "34", "bonito", "300", "coorde",  "https://acortar.link/NLHDgR");
    _setPlace(place);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingActionButton(onPressed: () { 
        createPlace();
         Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));}),
    );
  }
}
