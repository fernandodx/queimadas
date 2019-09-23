import 'dart:core' ;

class DetailFocus {

  LocationFocus location;
  PropertiesFocus properties;
  String type;
  String id;
  String geometry;

  DetailFocus.fromJson(Map<String, dynamic> map) {

    location = LocationFocus.fromJson(map["geometry"]);
    properties = PropertiesFocus.fromJson(map["properties"]);
    type = map["type"];
    id = map["id"];
    geometry = map["geometry_name"];
  }


}

class PropertiesFocus {

  double longitude;
  String dataHora;
  String satelite;
  double latitude;
  String pais;
  String estado;
  String municipio;

  PropertiesFocus.fromJson(Map<String, dynamic> map) {
    longitude = double.parse(map["longitude"].toString());
    dataHora = map["data_hora_gmt"];
    satelite = map["satelite"];
    latitude = double.parse(map["latitude"].toString());
    pais = map["pais"];
    estado = map["estado"];
    municipio = map["municipio"];
  }


}

class LocationFocus {
    String type;
    List<double> coordinates;

    LocationFocus.fromJson(Map<String, dynamic> map){
      type = map["type"];
      coordinates = map["coordinates"].map<double>((point) => double.parse(point.toString())).toList();
    }
}
