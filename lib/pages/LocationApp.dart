import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fluttertravelwild/models/place.dart';

class LocationAppExample extends StatefulWidget {
  final Place1 place;
  const LocationAppExample(this.place, {super.key});
//   // var store;

  // const DetailMovie({super.key});
  // const DetailMovie(this.movie);

  @override
  State<StatefulWidget> createState() => _LocationAppExampleState(place);
}

class _LocationAppExampleState extends State<LocationAppExample> {
  var place;
  _LocationAppExampleState(this.place);

  // _LocationAppExampleState(this.place);

  // print(this.place);

  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POI"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${this.place.nombresitio}"),
            Text("${this.place.direccion}"),
            // ValueListenableBuilder<GeoPoint?>(
            //   valueListenable: notifier,
            //   builder: (ctx, p, child) {
            //     return Center(
            //       child: Text(
            //         "${p?.toString() ?? ""}",
            //         textAlign: TextAlign.center,
            //       ),
            //     );
            //   },
            // ),
            Column(
              children: [
                // ElevatedButton(
                //   onPressed: () async {
                //     var p = await Navigator.pushNamed(context, "/search");
                //     if (p != null) {
                //       notifier.value = p as GeoPoint;
                //     }
                //   },
                //   child: Text("pick address"),
                // ),}

        
                
                ElevatedButton(
                  onPressed: () async {
                    var p = await showSimplePickerLocation(
                      context: context,
                      isDismissible: true,
                      title: this.place.nombresitio,
                      textConfirmPicker: "pick",
                      initCurrentUserPosition: false,
                      initZoom: 19,
                      initPosition: GeoPoint(
                          latitude: this.place.latitud,
                          longitude: this.place.longitud),
                      radius: 8.0,
                    );
                    if (p != null) {
                      notifier.value = p;
                    }
                  },
                  child: Text("show picker address"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//  return CustomPickerLocation(
//       controller: controller,
//       topWidgetPicker: Padding(
//         padding: const EdgeInsets.only(
//           top: 56,
//           left: 8,
//           right: 8,
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 TextButton(
//                   style: TextButton.styleFrom(),
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                   ),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: textEditingController,
//                     onEditingComplete: () async {
//                       FocusScope.of(context).requestFocus(new FocusNode());
//                     },
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.black,
//                       ),
//                       suffix: ValueListenableBuilder<TextEditingValue>(
//                         valueListenable: textEditingController,
//                         builder: (ctx, text, child) {
//                           if (text.text.isNotEmpty) {
//                             return child!;
//                           }
//                           return SizedBox.shrink();
//                         },
//                         child: InkWell(
//                           focusNode: FocusNode(),
//                           onTap: () {
//                             textEditingController.clear();
//                             controller.setSearchableText("");
//                             FocusScope.of(context).requestFocus(new FocusNode());
//                           },
//                           child: Icon(
//                             Icons.close,
//                             size: 16,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       focusColor: Colors.black,
//                       filled: true,
//                       hintText: "search",
//                       border: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       fillColor: Colors.grey[300],
//                       errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             TopSearchWidget()
//           ],
//         ),
//       ),
//       bottomWidgetPicker: Positioned(
//         bottom: 12,
//         right: 8,
//         child: FloatingActionButton(
//           onPressed: () async {
//             GeoPoint p = await controller.selectAdvancedPositionPicker();
//             Navigator.pop(context, p);
//           },
//           child: Icon(Icons.arrow_forward),
//         ),
//       ),
//       pickerConfig: CustomPickerLocationConfig(
//         initZoom: 8,
//       ),
//     );
//   }