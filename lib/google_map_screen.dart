import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final LatLng _initPosition = LatLng(11.568086, 104.894732);
  late GoogleMapController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          markers: {
            Marker(
                infoWindow: InfoWindow(title: 'Setec Institute'),
                position: LatLng(11.568086, 104.894732),
                markerId: MarkerId('SetecMarkerId')),
            Marker(
              markerId: MarkerId('AsiaEuroUniId'),
              position: LatLng(11.566048, 104.895342),
              infoWindow: InfoWindow(title: 'Asia Euro University'),
            )
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          initialCameraPosition:
              CameraPosition(target: _initPosition, zoom: 18)),
    );
  }
}
