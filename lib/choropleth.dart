import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart'; // For searching locations

class ChoroplethMap extends StatefulWidget {
  const ChoroplethMap({super.key});

  @override
  ChoroplethMapState createState() => ChoroplethMapState();
}

class ChoroplethMapState extends State<ChoroplethMap> {
  MapController mapController = MapController();
  TextEditingController searchController = TextEditingController();

  double zoomLevel = 5.0; // Initial zoom level

  // Function to search a location
  void _searchLocation() async {
    final query = searchController.text;
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        mapController.move(LatLng(location.latitude, location.longitude), zoomLevel);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location not found')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        title: const Text('Choropleth Map'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _searchLocation,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng(20.5937, 78.9629), // Center of India by default
          zoom: zoomLevel,
          minZoom: 2.0,
          maxZoom: 18.0,
          onPositionChanged: (position, hasGesture) {
            setState(() {
              zoomLevel = position.zoom ?? zoomLevel; // Use the current zoomLevel if position.zoom is null
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          // Choropleth polygons can be added as GeoJSON or hardcoded
          PolygonLayer(
            polygons: [
              Polygon(
                points: [
                  LatLng(20.5937, 78.9629), // Center of India
                  LatLng(21.0, 78.9629),
                  LatLng(21.0, 77.0),
                  LatLng(20.5937, 77.0),
                ],
                color: Colors.red.withOpacity(0.4), // Thermal color (this is just an example)
                borderColor: Colors.red,
                borderStrokeWidth: 2.0,
              ),
            ],
          ),
          // Adding a sample marker for demonstration purposes
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(20.5937, 78.9629), // Center of India
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.blue,
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
