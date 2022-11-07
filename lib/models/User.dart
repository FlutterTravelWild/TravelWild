import 'package:flutter/material.dart';

class User {
  var _uid;
  var _name;
  var _email;
  var _password;
  var _genre;
  var _typeS;
  var _bornDate;
  var _favtypeT;

  User(this._uid, this._name, this._typeS, this._genre, this._bornDate,
      this._email, this._favtypeT, this._password);

  // User.Empty();
  User.Empty();
// Per.fromJson
  User.fromJson(Map<String, dynamic> json)
      : _uid = json['uid'],
        _name = json['name'],
        _email = json['email'],
        _password = json['password'],
        _genre = json['genre'],
        _typeS = json['typeS'],
        _favtypeT = json['tourism'],
        _bornDate = json['borndate'];

  //  Map<String, dynamic> toJson() =>
  Map<String, dynamic> toJson() => {
        'uid': _uid,
        'name': _name,
        'email': _email,
        'password': _password,
        'genre': _genre,
        'typeS': _typeS,
        'tourism': _favtypeT,
        'borndate': _bornDate
      };

  get name => _name;
  set name(value) {
    _name = value;
  }

  get favtypeT => _favtypeT;
  set favtypeT(value) {
    _favtypeT = value;
  }

  get email => _email;
  set email(value) {
    _email = value;
  }

  get password => _password;
  set password(value) {
    _password = value;
  }

  get genre => _genre;
  set genre(value) {
    _genre = value;
  }

  get typeS => _typeS;
  set typeS(value) {
    _typeS = value;
  }

  get bornDate => _bornDate;
  set bornDate(value) {
    _bornDate = value;
  }

  get uid => _uid;
  set uid(value) {
    _uid = value;
  }

  void _showMsg(String msg, var context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Msg: ',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ));
  }
}
