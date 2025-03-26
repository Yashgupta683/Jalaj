import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const IndiaChoroplethMap());
}

class IndiaChoroplethMap extends StatelessWidget {
  const IndiaChoroplethMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'India Choropleth Map',
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
  List<Map<String, dynamic>> geoJsonData = [];
  String errorMessage = '';
  bool isLoading = true;

  // Sample state data
  final Map<String, Map<String, dynamic>> stateData = {
    'Maharashtra': {'value': 80, 'population': '112M', 'capital': 'Mumbai'},
    'Uttar Pradesh': {'value': 60, 'population': '199M', 'capital': 'Lucknow'},
    'Kerala': {'value': 40, 'population': '33M', 'capital': 'Thiruvananthapuram'},
    'Rajasthan': {'value': 20, 'population': '68M', 'capital': 'Jaipur'},
  };

  @override
  void initState() {
    super.initState();
    loadGeoJson();
  }

  // Load GeoJSON data
  Future<void> loadGeoJson() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/geohacker/india/master/state/india_telengana.geojson'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['features'] != null) {
          setState(() {
            geoJsonData = List<Map<String, dynamic>>.from(data['features']);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Invalid GeoJSON format: No features found';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load GeoJSON: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading GeoJSON: $e';
        isLoading = false;
      });
    }
  }

  // Function to determine color based on value
  Color getColorForValue(double value) {
    if (value > 70) return Colors.red.withOpacity(0.7);
    if (value > 50) return Colors.orange.withOpacity(0.7);
    if (value > 30) return Colors.yellow.withOpacity(0.7);
    return Colors.green.withOpacity(0.7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('India Choropleth Map')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : FlutterMap(
        options: MapOptions(
          center: LatLng(20.5937, 78.9629), // Center of India
          zoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),
          if (geoJsonData.isNotEmpty)
            PolygonLayer(
              polygons: geoJsonData.map((feature) {
                final stateName = feature['properties']['NAME_1'] ?? 'Unknown';
                final geometryType = feature['geometry']['type'];
                final coords = feature['geometry']['coordinates'] as List;

                List<List<LatLng>> coordinates = [];

                if (geometryType == 'Polygon') {
                  // For Polygon: coords is a list of rings, where the first ring is the outer boundary
                  coordinates = (coords as List).map((ring) {
                    return (ring as List).map((point) {
                      return LatLng(point[1], point[0]); // [lon, lat] -> LatLng(lat, lon)
                    }).toList();
                  }).toList();
                } else if (geometryType == 'MultiPolygon') {
                  // For MultiPolygon: coords is a list of polygons, each with its own rings
                  coordinates = (coords as List).expand((polygon) {
                    return (polygon as List).map((ring) {
                      return (ring as List).map((point) {
                        return LatLng(point[1], point[0]); // [lon, lat] -> LatLng(lat, lon)
                      }).toList();
                    });
                  }).toList();
                }

                double value = (stateData[stateName]?['value'] as num?)?.toDouble() ?? 0;
                return Polygon(
                  points: coordinates.isNotEmpty ? coordinates[0] : [],
                  color: getColorForValue(value),
                  borderColor: Colors.black,
                  borderStrokeWidth: 1.0,
                  isFilled: true,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}