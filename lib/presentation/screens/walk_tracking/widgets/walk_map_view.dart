import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class WalkMapView extends StatefulWidget {
  final ValueChanged<double> onDistanceUpdated;

  const WalkMapView({super.key, required this.onDistanceUpdated});

  @override
  State<WalkMapView> createState() => WalkMapViewState();
}


class WalkMapViewState extends State<WalkMapView> {
  // map and location variable
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionSubscription;
  List<LatLng> _routePoints = [];
  Set<Polyline> _polylines = {};
  double _totalDistance = 0.0;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(23.777176, 90.399452),
    zoom: 14.0,
  );


  @override
  void initState() {
    super.initState();
    _determinePosition(); //initial position
  }

  // location permission and current location
  Future<Position?> _determinePosition() async {

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude),
            17.0,
          ),
        );
      }
      return position;
    } catch (e) {
      print("Location error: $e");
      return null;
    }
  }


  // WalkProgressScreen
  void startLocationTracking() async {
    Position? initialPosition = await _determinePosition();
    if (initialPosition == null) return;

    _routePoints.clear();
    _totalDistance = 0.0;
    _routePoints.add(LatLng(initialPosition.latitude, initialPosition.longitude));
    _updatePolyline();


    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ).listen((Position newPosition) {
      _updateTracking(newPosition);
    });
  }

  void pauseLocationTracking() {
    _positionSubscription?.pause();
  }

  void stopLocationTracking() {
    _positionSubscription?.cancel();
    _polylines = {};
    _routePoints = [];
    _totalDistance = 0.0;
  }

  // Tracking update fintions
  void _updateTracking(Position newPosition) {
    if (_routePoints.isNotEmpty) {
      LatLng lastPoint = _routePoints.last;
      LatLng newPoint = LatLng(newPosition.latitude, newPosition.longitude);

      //distance (in meters)
      double distanceInMeters = Geolocator.distanceBetween(
        lastPoint.latitude,
        lastPoint.longitude,
        newPoint.latitude,
        newPoint.longitude,
      );

      // Total distance (in km)
      _totalDistance += distanceInMeters / 1000;

      // Distance update in main controller
      widget.onDistanceUpdated(_totalDistance);

      // UI update
      setState(() {
        _routePoints.add(newPoint);
        _updatePolyline();
      });


      _mapController?.animateCamera(
        CameraUpdate.newLatLng(newPoint),
      );
    }
  }

  // Polyline Update
  void _updatePolyline() {
    _polylines = {
      Polyline(
        polylineId: const PolylineId('walk_route'),
        points: _routePoints,
        color: Colors.blueAccent,
        width: 3,
      )
    };
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B33),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _initialCameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          polylines: _polylines,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
        ),
      ),
    );
  }
}