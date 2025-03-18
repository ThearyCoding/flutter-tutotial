import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng _initPosition = LatLng(11.568086, 104.894732);
  late GoogleMapController? _controller;
  final Set<Polyline> _polylines = {};
  final LatLng _startLocation = LatLng(11.556468, 104.928221);
  final LatLng _endLocation = LatLng(11.568086, 104.894732);

  @override
  initState() {
    super.initState();
//_getCurrentPosition();
  _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final apiKey = dotenv.get("LOCATIONIQ_API_KEY");

    final String url =
        "https://us1.locationiq.com/v1/directions/driving/${_startLocation.longitude},${_startLocation.latitude};${_endLocation.longitude},${_endLocation.latitude}?key=$apiKey&geometries=polyline";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String polyline = jsonDecode(response.body)['routes'][0]['geometry'];

        List<PointLatLng> result = PolylinePoints().decodePolyline(polyline);
        List<LatLng> polylineCoords = result
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        setState(() {
          _polylines.add(Polyline(
              polylineId: PolylineId('route'),
              color: Colors.blue,
              width: 5,
              points: polylineCoords));
        });
        _controller?.animateCamera(CameraUpdate.newLatLngBounds(LatLngBounds(southwest: LatLng(min(_startLocation.latitude, _endLocation.latitude),min(_startLocation.longitude, _endLocation.longitude)), northeast: LatLng(max(_startLocation.latitude, _endLocation.latitude), max(_startLocation.longitude, _endLocation.longitude))), 50));

      }
    } catch (e) {
      print("error fething direction: ${e}");
    }
  }

  Future<void> _getCurrentPosition() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location service is disabled.")));
    }

    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Location is denied."),
        ));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Location permission is permanently is denied")));
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _initPosition = LatLng(position.latitude, position.longitude);
    });

    _controller?.animateCamera(CameraUpdate.newLatLngZoom(_initPosition, 18));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          markers: {
            // Marker(
            //     infoWindow: InfoWindow(title: 'Setec Institute'),
            //     position: LatLng(11.568086, 104.894732),
            //     markerId: MarkerId('SetecMarkerId')),
            // Marker(
            //   markerId: MarkerId('AsiaEuroUniId'),
            //   position: LatLng(11.566048, 104.895342),
            //   infoWindow: InfoWindow(title: 'Asia Euro University'),
            // ),
          },
          polylines: _polylines,
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
