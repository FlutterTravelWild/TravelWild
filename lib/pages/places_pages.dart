import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelwild/models/place.dart';
import 'package:fluttertravelwild/pages/DetailPage.dart';
// import 'dart:html';

class PlaceStorePage extends StatefulWidget {
  const PlaceStorePage({super.key});

  @override
  State<PlaceStorePage> createState() => _PlaceStorePageState();
}

class _PlaceStorePageState extends State<PlaceStorePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: AppBar(
        title: Text("Medellin  POI"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("places").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Places");
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot store = snapshot.data!.docs[index];

                    // print(store.get('TIPOATRACTIVO'));

                    var text = Text(store['NOMBRESITIO'] ?? "Not title");
                    var text2 = Text(store['TIPOATRACTIVO'] ?? "Not describe");
                    var img = ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(48), // Image radius
                        child: Image.network(store['IMAGEN'] ?? "",
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                          return const Image(
                              image: AssetImage('assets/img/baggage.png'));
                        }, fit: BoxFit.cover),
                      ),
                    );

                    return Card(
                      child: ListTile(
                        title: text,
                        subtitle: text2,
                        leading: img,
                        onTap: () {
                          Place1 place = Place1.empty();
                          place.tipoatractivo = store.get("TIPOATRACTIVO");
                          place.barrio = store.get("BARRIO");
                          place.comuna = store.get("COMUNA");
                          place.direccion = store.get("DIRECCION");
                          place.imagen = store.get("IMAGEN");
                          place.codComuna = store.get("COD_COMUNA");
                          place.imperdible = store.get("IMPERDIBLE");
                          place.label = store.get("LABEL");
                          place.nombresitio = store.get("NOMBRESITIO");
                          place.latitud = store.get("LATITUD");
                          place.longitud = store.get("LONGITUD");
                          place.objectid = store.get("OBJECTID");
                          place.xMagnamed = store.get("X_MAGNAMED");
                          place.yMagnamed = store.get("Y_MAGNAMED");
                          place.x = store.get("X");
                          place.y = store.get("Y");
                 
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPlace(place)));
                        },
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
