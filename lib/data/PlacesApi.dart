// import 'package:mislibros/models/results.dart'v;

import 'package:fluttertravelwild/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:csv/csv.dart';

// import 'package:';

class PlacesAPi {
  Future<Place> getPlaces() async {
    String url =
        "https://docs.google.com/spreadsheets/d/e/2PACX-1vRK86_nSn34gvaxP9T6q1wrXpTZS-sSxLh0wbxZCA4VPKdzG-kWuwWL4n6ciqnclEJp-tKNP22sIyQw/pub?output=csv";
    // String uri = url + parameter;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // return Results.fromJson(jsonDecode(response.body));
      var data = response.body;

      Map<String, dynamic> _apiPlace = apiPlace(data);
      // return Place.fromJson(jsonDecode(_apiPlace));
      print("JsonDecode");
      // var dat = jsonDecode(_apiPlace);
      print("result");
      // print(dat);

      return Place.fromJson(_apiPlace);
    } else {
      throw Exception("Failed to load books");
    }
  }

  Map<String, dynamic> itemJson(valueList, List<String> claveList) {
    var h = 0;
    // String claveList = claveList;
    var placeN = {for (var value in valueList) claveList[h++]: value};

    return placeN;
  }

  Map<String, dynamic> apiPlace(data) {
    List<List<dynamic>> df = const CsvToListConverter().convert(data);

    // ignore: non_constant_identifier_names
    List ItemsP = [];
    List<String> claveList = List<String>.from(df[0] as List);
    for (var i = 1; i < df.length; i++) {
      List valueList = df[i];
      Map placeN = itemJson(valueList, claveList);
      ItemsP.add(placeN);
    }

    // ignore: non_constant_identifier_names
    Map<String, dynamic> Api = {"Place": ItemsP};
    // print(Api.keys);
    // String json = jsonEncode(ItemsP);
    // print(json);
    return Api;
  }
}
