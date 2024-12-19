import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PointMap extends StatelessWidget {
  const PointMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        title: const Text('Point/ Dot Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(20.5937, 78.9629), // Centered at India
          zoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(20.5937, 78.9629), // Marking India's center
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
              // Add more markers here for other points
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(28.7041, 77.1025), // Example point (Delhi)
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
