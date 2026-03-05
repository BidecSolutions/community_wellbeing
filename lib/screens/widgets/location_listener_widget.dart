import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';

class LocationListenerWidget extends StatefulWidget {
  final Function(Position) onLocationFetched;

  const LocationListenerWidget({super.key, required this.onLocationFetched});

  @override
  State<LocationListenerWidget> createState() => _LocationListenerWidgetState();
}

class _LocationListenerWidgetState extends State<LocationListenerWidget> {
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  void _fetchLocation() async {
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        widget.onLocationFetched(position);
      }
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Doesn't show UI
  }
}
