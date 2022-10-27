import 'package:flutter/material.dart';
import 'package:fluttertravelwild/models/Place.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String imageURL = "https://acortar.link/NLHDgR";

  Place place = Place(
      "",
      "guatape",
      "medellin",
      "34",
      "Lorem ipsum dolor, sit amet consectetur adipisicing elit. In dignissimos iure, explicabo quibusdam mollitia molestias, ullam saepe beatae asperiores quas dicta rem soluta nihil praesentium sit culpa. Asperiores, at recusandae?",
      "300",
      "coorde",
      "https://acortar.link/NLHDgR");
  String imageURL =
      "https://images.pexels.com/photos/12470916/pexels-photo-12470916.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
  Place placeLoad = Place.Empty();
    double _rating = 3.0;

  @override
  void initState() {
    _getPlace();
    super.initState();
  }

  _getPlace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap =
        jsonDecode(prefs.getString("place")!); // ! quita null
    // userLoad = "f" as User;
    placeLoad = Place.fromJson(userMap);
    // print(placeLoad.img);
  }


  Widget build(BuildContext context) {
    
    final rating = RatingBar.builder(
        initialRating: 3,
        maxRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: (rating) {
          _rating = rating;
        });
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Descripcion',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  place.description,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          // Icon(
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
          // Text('11'),
        ],
      ),
    );
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget contenSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BuildTitlesection(Icons.place_rounded, "Ciudad:", place.name),
          _BuildTitlesection(Icons.sunny, "Departameto:", "Antioquia"),
          _BuildTitlesection(
              Icons.thermostat_rounded, "Temperatura:", place.temp),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TravelWild Colombia-Medellín",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Lugares"),
              Image(
                image: NetworkImage(place.img),
                // width: 200,
                //  imageURL != null ? NetworkImage(imageURL) : null
              ),
              const SizedBox(
                height: 10,
              ),
              rating
                , const SizedBox(
                height: 10,
              ),
              contenSection,
              titleSection,
              buttonSection,
            ],
          ),
        )),
      ),
    );
  }
}

Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Row _BuildTitlesection(IconData icon, String title, String content) {
  return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          width: 30,
        ),
        Text(content,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            )),
        Spacer(),
        Icon(
          icon,
          color: Colors.green,
        ),
        const SizedBox(
          width: 30,
        )
      ]);
}
