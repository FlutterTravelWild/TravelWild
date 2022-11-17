import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertravelwild/boxes.dart';
import 'package:fluttertravelwild/models/local_sities.dart';
import 'package:fluttertravelwild/models/place.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertravelwild/pages/ListplacePage.dart';
import 'package:fluttertravelwild/pages/Login_page.dart';
// import 'package:moviedb/model/result.dart';

class DetailPlace extends StatefulWidget {
  final Place1 place;

  // const DetailMovie({super.key});
  const DetailPlace(this.place);

  @override
  State<DetailPlace> createState() => _DetailPlaceState();
}

class _DetailPlaceState extends State<DetailPlace> {
  final box = Boxes.getFavoritesBox();
  bool isSaved = false;

  void _onFavoritesButtonClicked() {
    var localPlace = LocalSities()
      ..description = generateDescription()
      ..imageLink = widget.place.imagen
      ..id = widget.place.nombresitio
      ..name = widget.place.nombresitio;

    bool isPresent = checkIfSaved(localPlace.name!);

    if (isPresent) {
      print("The place is already saved ${widget.place.nombresitio}");
    } else {
      print("Adding place to the box with name ${widget.place.nombresitio}");
      box.add(localPlace);

      setState(() {
        isSaved = true;
      });
    }
  }

  void _onRemoveFavoritesButtonClicked() {
    bool isPresent = false;
    dynamic placeKey;

    box.values.forEach(
      (place) {
        if (place.name == widget.place.nombresitio) {
          isPresent = true;
          placeKey = place.key;
        }
      },
    );

    if (isPresent) {
      print("Deliting place with name ${widget.place.nombresitio}");
      box.delete(placeKey);
      setState(() {
        isSaved = false;
      });
    }
  }

  bool checkIfSaved(String name) {
    bool isPresent = false;
    box.values.forEach(
      (place) {
        if (place.name == name) {
          isPresent = true;
        }
      },
    );

    return isPresent;
  }

  String generateDescription() {
    return '''Hermoso lugar llamado ${widget.place.nombresitio}, ubicado en 
el  barrio ${widget.place.barrio} con dirección  ${widget.place.direccion}  en la comuna  ${widget.place.comuna}  es un atractivo
 tipo  ${widget.place.tipoatractivo}, no te  lo puedes perder.''';
  }

  @override
  Widget build(BuildContext context) {
    double _rating = 3.0;

    isSaved = checkIfSaved(widget.place.nombresitio!);

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
                    widget.place.nombresitio.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Descripción',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  generateDescription(),
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
          _BuildTitlesection(Icons.place_rounded, "Ciudad:", "Medellin"),
          _BuildTitlesection(Icons.sunny, "Departameto:", "Antioquia"),
          _BuildTitlesection(
              Icons.thermostat_rounded, "Temperatura:", "27.3  ºC"),
        ],
      ),
    );

    return Scaffold(
      // appBar: AppBar(title: Text(place.tipoatractivo ?? "Detalle")),
      appBar: AppBar(
        title: Text(
          "TravelWild Colombia-Medellín",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (Menu item) {
              setState(() {
                if (item == Menu.logOut) {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem(
                value: Menu.logOut,
                child: Text("Cerrar sesion"),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network(
                  widget.place.imagen ?? "",
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Image(image: AssetImage('assets/img/baggage'));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                rating,
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: isSaved
                            ? IconButton(
                                alignment: Alignment.topRight,
                                icon: const Icon(Icons.favorite),
                                color: Colors.red,
                                onPressed: (() {
                                  _onRemoveFavoritesButtonClicked();
                                }),
                              )
                            : IconButton(
                                alignment: Alignment.topRight,
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.red,
                                onPressed: (() {
                                  _onFavoritesButtonClicked();
                                }))),
                  ],
                ),
                contenSection,
                titleSection,
                buttonSection,
              ]),
        ),
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
