import 'package:flutter/material.dart';
import 'package:fluttertravelwild/data/PlacesApi.dart';
import 'package:fluttertravelwild/pages/DetailPage.dart';

import '../models/place.dart';

import 'package:fluttertravelwild/data/firebase_api.dart';

class ListplacePage extends StatefulWidget {
  const ListplacePage({super.key});

  @override
  State<ListplacePage> createState() => _ListplacePageState();
}

class _ListplacePageState extends State<ListplacePage> {
  final _parameter = TextEditingController();
  // PlacesAPi _placeApi = PlacesAPi();
  // FirebaseApi _firebaseApi 
  List<Place1> listPlace = <Place1>[];
  final FirebaseApi _firebaseApi = FirebaseApi();
  @override
  void initState() {
    _getPlace();
    // _searchMovie();
    super.initState();
  }
  Future _getPlace() async {
    // print("search");
    // Place? resultsFuture = await _firebaseApi.getPlace();

    setState(() {
      // resultsFuture?.forEach((element) {
      //   listPlace.add(element);
      // });
      // print(resultsFuture);
    });

    // print(listBooks.length);
  }
  // Future _searchMovie() async {
  //   Place resultsFuture = await _movieApi.getPlaces();


  //   setState(() {
  //     resultsFuture.place?.forEach((element) {
  //       listMovie.add(element);
  //       // print("data");
  //       // print(element);
  //       // var createPlace = _firebaseApi.createPlace(element);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    int nPlace = listPlace.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Medellin ${nPlace} POI"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Center(
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: listPlace.length,
                        itemBuilder: (BuildContext context, index) {
                          Place1 movie = listPlace[index];

                          var text = Text(movie.barrio ?? "Not title");
                          var text2 =
                              Text(movie.tipoatractivo ?? "Not describe");
                          var img = ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(48), // Image radius
                              child: Image.network(movie.imagen ?? "",
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                return const Image(
                                    image:
                                        AssetImage('assets/img/baggage.png'));
                              }, fit: BoxFit.cover),
                            ),
                          );

                          return Card(
                            child: ListTile(
                              title: text,
                              subtitle: text2,
                              leading: img,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPlace(movie)));
                              },
                            ),
                          );
                        }))
              ],
            ),
          )),
    );
  }
}
