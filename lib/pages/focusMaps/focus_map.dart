import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FocusMap extends StatefulWidget {
  @override
  _FocusMapState createState() => _FocusMapState();
}

class _FocusMapState extends State<FocusMap> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set.of(_getListaMarkes()),
        zoomGesturesEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition:_kGooglePlex,
        onMapCreated: (GoogleMapController mapController) {
          _controller.complete(mapController);
        },
      ),
    );

  }


  _changeLocation() async {
    final googleController = await _controller.future;
    googleController.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  List<Marker> _getListaMarkes() {
    return [
      Marker(
        markerId: MarkerId("local 1"),
        position: LatLng(37.42796133580664, -122.085749655962),
        infoWindow: InfoWindow(
          title: "Google Plex",
          snippet: "Local Escolhido",
          onTap: () => print("Clicou na janela!!!")
        ),
        onTap: () => print("Clicou no pin"),
      ),
      Marker(
        markerId: MarkerId("local 2"),
        position: LatLng(37.43296265331129, -122.08832357078792),
        infoWindow: InfoWindow(
            title: "Google Plex 2",
            snippet: "Local Escolhido 2",
            onTap: () => print("Clicou na janela 2!!!")
        ),
        onTap: () => print("Clicou no pin 2"),
      )
    ];
  }
}
