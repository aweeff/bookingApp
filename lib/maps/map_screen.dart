import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double? departureLatitude;
  final double? departureLongitude;
  final double? destinationLatitude;
  final double? destinationLongitude;

  const MapScreen({
    Key? key,
    this.departureLatitude,
    this.departureLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
  }) : super(key: key);
  LatLng calculateMidpoint(double lat1, double lng1, double lat2, double lng2) {
    return LatLng((lat1 + lat2) / 2, (lng1 + lng2) / 2);
  }


  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};

    // Add departure marker if coordinates are provided
    if (departureLatitude != null && departureLongitude != null) {
      markers.add(
        Marker(
          markerId: MarkerId("departure"),
          position: LatLng(departureLatitude!, departureLongitude!),
          infoWindow: InfoWindow(title: "Departure Location"),
        ),
      );
    }

    // Add destination marker if coordinates are provided
    if (destinationLatitude != null && destinationLongitude != null) {
      markers.add(
        Marker(
          markerId: MarkerId("destination"),
          position: LatLng(destinationLatitude!, destinationLongitude!),
          infoWindow: InfoWindow(title: "Destination Location"),
        ),
      );
    }

    // Calculate the initial camera position
    CameraPosition initialCamera;
    if (departureLatitude != null && departureLongitude != null && destinationLatitude != null && destinationLongitude != null) {
      LatLng midpoint = calculateMidpoint(
          departureLatitude!,
          departureLongitude!,
          destinationLatitude!,
          destinationLongitude!
      );
      initialCamera = CameraPosition(target: midpoint, zoom: 4);
    } else {
      initialCamera = CameraPosition(target: LatLng(51.16, 71.43), zoom: 5); // Default coordinates
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCamera,
        markers: markers,
        mapType: MapType.normal,
      ),
    );
  }
}
