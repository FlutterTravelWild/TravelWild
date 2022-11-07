import 'package:flutter/material.dart';
import 'package:fluttertravelwild/data/PlacesApi.dart';
import 'package:fluttertravelwild/pages/DetailPage.dart';

import '../models/place.dart';

class ListplacePage extends StatefulWidget {
  const ListplacePage({super.key});

  @override
  State<ListplacePage> createState() => _ListplacePageState();
}

class _ListplacePageState extends State<ListplacePage> {
  final _parameter = TextEditingController();
  PlacesAPi _movieApi = PlacesAPi();
  List<Place1> listMovie = <Place1>[];
  @override
  void initState() {
    // _getPlace();
    _searchMovie();
    super.initState();
  }

  Future _searchMovie() async {
    Place resultsFuture = await _movieApi.getPlaces();

    setState(() {
      resultsFuture.place?.forEach((element) {

        listMovie.add(element);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    int nPlace = listMovie.length;
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
                        itemCount: listMovie.length,
                        itemBuilder: (BuildContext context, index) {
                          Place1 movie = listMovie[index];

                          var text = Text(movie.barrio ?? "Not title");
                          var text2 =
                              Text(movie.tipoatractivo ?? "Not describe");
                          var img =ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(48), // Image radius
                              child: Image.network(
                            movie.imagen ?? "",
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Image(
                                  image: AssetImage('assets/img/baggage.png'));
                            },
                          fit: BoxFit.cover)
                                ,
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
