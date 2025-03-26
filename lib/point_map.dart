import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const IndiaPointMap());
}

class IndiaPointMap extends StatelessWidget {
  const IndiaPointMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'India State Map',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<Map<String, dynamic>> stateData = [
    {
      'name': 'Maharashtra',
      'lat': 19.7515,
      'lon': 75.7139,
      'capital': 'Mumbai',
      'population': '112M',
      'area': '307,713 km²'
    },
    {
      'name': 'Karnataka',
      'lat': 15.3173,
      'lon': 75.7139,
      'capital': 'Bengaluru',
      'population': '61M',
      'area': '191,791 km²'
    },
    {
      'name': 'Uttar Pradesh',
      'lat': 26.8467,
      'lon': 80.9462,
      'capital': 'Lucknow',
      'population': '199M',
      'area': '243,286 km²'
    },
    {
      'name': 'Tamil Nadu',
      'lat': 11.1271,
      'lon': 78.6569,
      'capital': 'Chennai',
      'population': '72M',
      'area': '130,058 km²'
    },
    {
      'name': 'Rajasthan',
      'lat': 27.0238,
      'lon': 74.2179,
      'capital': 'Jaipur',
      'population': '68M',
      'area': '342,239 km²'
    },
  ];

  Map<String, dynamic>? selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('India State Map'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              center: LatLng(20.5937, 78.9629),
              zoom: 5.0,
              minZoom: 4.0,
              maxZoom: 10.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  for (var state in stateData)
                    Marker(
                      point: LatLng(state['lat'], state['lon']),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedState = state;
                          });
                        },
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (selectedState != null)
            Positioned(
              right: 20,
              top: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 4)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedState!['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Capital: ${selectedState!['capital']}'),
                    Text('Population: ${selectedState!['population']}'),
                    Text('Area: ${selectedState!['area']}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedState = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}