
class Place {
  List<Place1>? place;

  Place({this.place});

  Place.fromJson(Map<String, dynamic> json) {
    if(json["Place"] is List) {
      place = json["Place"] == null ? null : (json["Place"] as List).map((e) => Place1.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(place != null) {
      _data["Place"] = place?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Place1 {
  double? x;
  double? y;
  int? objectid;
  String? nombresitio;
  String? imagen;
  String? imperdible;
  String? tipoatractivo;
  String? label;
  String? direccion;
  int? codComuna;
  int? comuna;
  String? barrio;
  double? xMagnamed;
  double? yMagnamed;
  double? latitud;
  double? longitud;

  Place1({this.x, this.y, this.objectid, this.nombresitio, this.imagen, this.imperdible, this.tipoatractivo, this.label, this.direccion, this.codComuna, this.comuna, this.barrio, this.xMagnamed, this.yMagnamed, this.latitud, this.longitud});

  Place1.fromJson(Map<String, dynamic> json) {
    if(json["X"] is double) {
      x = json["X"];
    }
    if(json["Y"] is double) {
      y = json["Y"];
    }
    if(json["OBJECTID"] is int) {
      objectid = json["OBJECTID"];
    }
    if(json["NOMBRESITIO"] is String) {
      nombresitio = json["NOMBRESITIO"];
    }
    if(json["IMAGEN"] is String) {
      imagen = json["IMAGEN"];
    }
    if(json["IMPERDIBLE"] is String) {
      imperdible = json["IMPERDIBLE"];
    }
    if(json["TIPOATRACTIVO"] is String) {
      tipoatractivo = json["TIPOATRACTIVO"];
    }
    if(json["LABEL"] is String) {
      label = json["LABEL"];
    }
    if(json["DIRECCION"] is String) {
      direccion = json["DIRECCION"];
    }
    if(json["COD_COMUNA"] is int) {
      codComuna = json["COD_COMUNA"];
    }
    if(json["COMUNA"] is int) {
      comuna = json["COMUNA"];
    }
    if(json["BARRIO"] is String) {
      barrio = json["BARRIO"];
    }
    if(json["X_MAGNAMED"] is double) {
      xMagnamed = json["X_MAGNAMED"];
    }
    if(json["Y_MAGNAMED"] is double) {
      yMagnamed = json["Y_MAGNAMED"];
    }
    if(json["LATITUD"] is double) {
      latitud = json["LATITUD"];
    }
    if(json["LONGITUD"] is double) {
      longitud = json["LONGITUD"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["X"] = x;
    _data["Y"] = y;
    _data["OBJECTID"] = objectid;
    _data["NOMBRESITIO"] = nombresitio;
    _data["IMAGEN"] = imagen;
    _data["IMPERDIBLE"] = imperdible;
    _data["TIPOATRACTIVO"] = tipoatractivo;
    _data["LABEL"] = label;
    _data["DIRECCION"] = direccion;
    _data["COD_COMUNA"] = codComuna;
    _data["COMUNA"] = comuna;
    _data["BARRIO"] = barrio;
    _data["X_MAGNAMED"] = xMagnamed;
    _data["Y_MAGNAMED"] = yMagnamed;
    _data["LATITUD"] = latitud;
    _data["LONGITUD"] = longitud;
    return _data;
  }
}