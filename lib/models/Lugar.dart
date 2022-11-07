// import 'package:flutter/material.dart';

// class Place {
//   var _uid;
//   var _name;
//   var _img;
//   var _ubication;
//   var _description;
//   var _city;
//   var _temp;
//   var _other;

//   Place(this._uid, this._name, this._city, this._temp, this._description,
//       this._other, this._ubication,this._img);

  

//   Place.Empty();
// // Per.fromJson
//   Place.fromJson(Map<String, dynamic> json)
//       : _uid = json['uid'],
//         _name = json['name'],
//         _city = json['city'],
//         _temp = json['temp'],
//         _description = json['description'],
//         _other = json['other'],
//         _ubication = json['ubication'],
//         _img = json['img'];

//   //  Map<String, dynamic> toJson() =>
//   Map<String, dynamic> toJson() => {
//         'uid': _uid,
//         'name': _name,
//         'city': _city,
//         'temp': _temp,
//         'description': _description,
//         'other': _other,
//         'ubication': _ubication,
//         'img': _img
//       };

//   get name => _name;
//   set name(value) {
//     _name = value;
//   }  
//   get img => _img;
//   set img(value) {
//     _img = value;
//   }

//   get city => _city;
//   set city(value) {
//     _city = value;
//   }

//   get temp => _temp;
//   set temp(value) {
//     _temp = value;
//   }

//   get description => _description;
//   set description(value) {
//     _description = value;
//   }

//   get other => _other;
//   set other(value) {
//     _other = value;
//   }

//   get ubication => _ubication;
//   set ubication(value) {
//     _ubication = value;
//   }

//   get uid => _uid;
//   set uid(value) {
//     _uid = value;
//   }

//   void _showMsg(String msg,var context ) {
//     final scaffold = ScaffoldMessenger.of(context);
//     scaffold.showSnackBar(SnackBar(
//       content: Text(msg),
//       action: SnackBarAction(
//         label: 'Msg: ',
//         onPressed: scaffold.hideCurrentSnackBar,
//       ),
//     ));
//   }
// }
