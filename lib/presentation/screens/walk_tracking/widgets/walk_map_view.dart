import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class WalkMapView extends StatefulWidget {
  final List<LatLng> initialRoutePoints;

  const WalkMapView({
    super.key,
    this.initialRoutePoints = const [],
  });

  @override
  State<WalkMapView> createState() => WalkMapViewState();
}


class WalkMapViewState extends State<WalkMapView> {
  // map and location variable
  GoogleMapController? _mapController;
  List<LatLng> _routePoints = [];
  Set<Polyline> _polylines = {};

  bool _isLoading = false;
  Set<Marker> _markers = {};


  // Initial map position - Dhaka
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(23.777176, 90.399452),
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _routePoints = widget.initialRoutePoints;

    if (_routePoints.isNotEmpty) {
      _updatePolyline();
    } else {
      _tryInitialLocation();
    }
  }

  void updateRoute(List<LatLng> newRoutePoints) {
    if (!mounted) return;

    setState(() {
      _routePoints = newRoutePoints;
      _updatePolyline();

      // Update Marker (last point)
      if (_routePoints.isNotEmpty) {
        _updateLocationMarker(_routePoints.last);
      }
    });

    // Animate camera to the current location (only when tracking is active)
    if (widget.initialRoutePoints.isEmpty && _routePoints.isNotEmpty && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(_routePoints.last),
      );
    }
  }


  //  Map and Location Setup

  void _tryInitialLocation() async {
    setState(() {
      _isLoading = true;
    });
    // For non-tracking initial view, we still try to get a location
    Position? pos = await _getCurrentPosition(requestPermission: false, showDialog: false);
    if (pos != null) {
      _updateLocationMarker(LatLng(pos.latitude, pos.longitude));
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(
              LatLng(pos.latitude, pos.longitude), 17.0
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }


  // Marker update function
  void _updateLocationMarker(LatLng latLng) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'Current Location / End Point'),
        )
      };
    });
  }
   // route center function for  summary page
    void _centerMapOnRoute() {
    if (_routePoints.isEmpty || _mapController == null) return;

    double minLat = _routePoints.map((p) => p.latitude).reduce(min);
    double maxLat = _routePoints.map((p) => p.latitude).reduce(max);
    double minLng = _routePoints.map((p) => p.longitude).reduce(min);
    double maxLng = _routePoints.map((p) => p.longitude).reduce(max);

    // Update Marker (last point)
    if (_routePoints.isNotEmpty) {
      _updateLocationMarker(_routePoints.last);
    }


    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          50
      ),
    );
  }

  // Utility to get current position once
  Future<Position?> _getCurrentPosition({bool requestPermission = true, bool showDialog = true}) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (requestPermission) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return null;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      return position;
    } catch (e) {
      return null;
    }
  }


  // Polyline update function
  void _updatePolyline() {
    _polylines = {
      Polyline(
        polylineId: const PolylineId('walk_route'),
        points: _routePoints,
        color: Colors.blueAccent,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      )
    };
  }

  // Control Methods
  List<LatLng> getRoutePoints() {
    return _routePoints;
  }



  @override
  Widget build(BuildContext context) {
    final bool isTrackingMode = widget.initialRoutePoints.isEmpty;

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B33),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition,
              myLocationButtonEnabled: false,
              polylines: _polylines,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (!isTrackingMode) {
                  _centerMapOnRoute();
                } else if (_routePoints.isEmpty) {
                  _tryInitialLocation();
                }
              },
            ),


            if (_isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.blueAccent),
                      SizedBox(height: 10),
                      Text("Finding location...", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),


            if (isTrackingMode)
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () => _tryInitialLocation(), // Re-center on current location
                  backgroundColor: Colors.white,
                  mini: true,
                  child: const Icon(Icons.my_location, color: Color(0xFF1B2B33)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}