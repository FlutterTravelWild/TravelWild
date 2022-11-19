import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fluttertravelwild/models/place.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SimpleExample extends StatefulWidget {
  final Place1 place;
  // SimpleExample({Key? key}) : super(key: key);
  const SimpleExample(this.place, {super.key});

  @override
  _SimpleExampleState createState() => _SimpleExampleState(place);
}

class _SimpleExampleState extends State<SimpleExample> {
  var place;
  _SimpleExampleState(this.place);
  late PageController controller;
  late int indexPage;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1);
    indexPage = controller.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POI"),
      ),
      body: PageView(
        // ignore: sort_child_properties_last
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.network(
                      widget.place.imagen ?? "",
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Image(
                            image: AssetImage('assets/img/baggage'));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("${widget.place.nombresitio}")),
                        Expanded(child: Text("${widget.place.direccion}")),
                      ],
                    ),
                  ]),
            ),
          ),
          SimpleOSM(this.place),
        ],
        controller: controller,
        onPageChanged: (p) {
          setState(() {
            indexPage = p;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPage,
        onTap: (p) {
          controller.animateToPage(p,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "information",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "map",
          ),
        ],
      ),
    );
  }
}

class SimpleOSM extends StatefulWidget {

  final Place1 place;

  const SimpleOSM(this.place, {super.key});

  @override
  State<StatefulWidget> createState() => SimpleOSMState(place);
}

class SimpleOSMState extends State<SimpleOSM>
    with AutomaticKeepAliveClientMixin {
  var place;
  SimpleOSMState(this.place);
  late MapController controller;



  @override
  void initState() {
    super.initState();

    controller = MapController(
      initMapWithUserPosition: false,

      initPosition: GeoPoint(
        latitude: this.place.latitud,
        longitude: this.place.longitud,
      ),

    );


  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return OSMFlutter(
      controller: controller,
      initZoom: 17,
      showZoomController: true,
      showDefaultInfoWindow: true,

      markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 100,
            ),
          ),
          advancedPickerMarker:const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.red,
              size: 200,
            ),
      
          )),

      trackMyPosition: false,

      isPicker: true,
    
    );
  }

  @override
  bool get wantKeepAlive => true;
}



