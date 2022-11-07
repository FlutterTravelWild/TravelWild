import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertravelwild/models/place.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:moviedb/model/result.dart';

class DetailPlace extends StatelessWidget {
  final Place1 place;
  
  // const DetailMovie({super.key});
  const DetailPlace(this.place);

  @override
  Widget build(BuildContext context) {
double _rating = 3.0;

String description = '''Hermoso lugar llamado ${place.nombresitio}, ubicado en 
el  barrio ${place.barrio} con dirección  ${place.direccion}  en la comuna  ${place.comuna}  es un atractivo
 tipo  ${place.tipoatractivo}, no te  lo puedes perder.''';
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
                    place.nombresitio.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                  ,
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Descripción',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(description
                ,
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
          _BuildTitlesection(Icons.place_rounded, "Ciudad:","Medellin" ),
          _BuildTitlesection(Icons.sunny, "Departameto:", "Antioquia"),
          _BuildTitlesection(Icons.thermostat_rounded, "Temperatura:", "27.3  ºC"),
        ],
      ),
    );

    return Scaffold(
      // appBar: AppBar(title: Text(place.tipoatractivo ?? "Detalle")),
      appBar: AppBar(title: Text(
          "TravelWild Colombia-Medellín",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:<Widget> [
            Image.network(
              place.imagen ?? "",
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Image(
                    image: AssetImage('assets/img/baggage'));
              },
            ),
                 const SizedBox(
                  height: 10,
                ),
                rating,
                const SizedBox(
                  height: 10,
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
