import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:queimadas/utils/gps_util.dart';

class FocusMap extends StatefulWidget {
  @override
  _FocusMapState createState() => _FocusMapState();
}

class _FocusMapState extends State<FocusMap> {
  List<Marker> _listMarkers = [];
  var gps = GPSUtil();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();

    _initListenerLocation();
  }

  Future<LocationData> lastLocationAndConfig() async {
    return gps.getLastLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lastLocationAndConfig(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LocationData data = snapshot.data;

            var cameraPosition = CameraPosition(
              target: LatLng(data.latitude, data.longitude),
              zoom: 17,
            );

            return _createGoogleMaps(cameraPosition);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  GoogleMap _createGoogleMaps(CameraPosition lastLocation) {
    return GoogleMap(
      markers: Set.of(listMarkers),
      zoomGesturesEnabled: true,
      mapType: MapType.hybrid,
      initialCameraPosition: lastLocation,
      onMapCreated: (GoogleMapController mapController) {
        _controller.complete(mapController);
      },
    );
  }

  _initListenerLocation() async {

    await gps.changeDefaultSettings(accuracy: LocationAccuracy.BALANCED, interval: 8000, distanceFilter: 100.0);

    gps.onLocationChanged((LocationData data) {
      var latlng = LatLng(data.latitude, data.longitude);

      var cameraPosition = CameraPosition(target: latlng, zoom: 17);

      var marker = _createMarker("Marker", latlng,
          () => print("Clicou o marker ${latlng.toString()}"));

      _changeLocation(cameraPosition, marker: marker);
    });
  }

  _changeLocation(CameraPosition position, {Marker marker}) async {
    final googleController = await _controller.future;
    googleController.animateCamera(CameraUpdate.newCameraPosition(position));

    if (marker != null) {
      setState(() {
        listMarkers.add(marker);
      });
    }
  }

  _createMarker(String titulo, LatLng latLng, Function onTap) {
    return Marker(
      markerId: MarkerId("${titulo}_${latLng.toString()}"),
      position: latLng,
      infoWindow:
          InfoWindow(title: titulo, snippet: "Local Escolhido", onTap: onTap),
      onTap: () => print("Clicou no pin"),
    );
  }

  List<Marker> _getListaMarkesMock() {
    return [
      Marker(
        markerId: MarkerId("local 1"),
        position: LatLng(37.42796133580664, -122.085749655962),
        infoWindow: InfoWindow(
            title: "Google Plex",
            snippet: "Local Escolhido",
            onTap: () => print("Clicou na janela!!!")),
        onTap: () => print("Clicou no pin"),
      ),
      Marker(
        markerId: MarkerId("local 2"),
        position: LatLng(37.43296265331129, -122.08832357078792),
        infoWindow: InfoWindow(
            title: "Google Plex 2",
            snippet: "Local Escolhido 2",
            onTap: () => print("Clicou na janela 2!!!")),
        onTap: () => print("Clicou no pin 2"),
      )
    ];
  }

  List<Marker> get listMarkers => _listMarkers;

  set listMarkers(List<Marker> value) {
    _listMarkers = value;
  }
}
