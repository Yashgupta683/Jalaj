import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/coa.dart';

import 'package:untitled/mappage.dart';
import 'package:untitled/profile.dart';

import 'package:untitled/comparemodels.dart';
import 'package:untitled/areadetails.dart';


class DisasterHomeAPage extends StatefulWidget {
  const DisasterHomeAPage({super.key});

  @override
  State<DisasterHomeAPage> createState() => _DisasterHomeAPageState();
}

class _DisasterHomeAPageState extends State<DisasterHomeAPage> {
  String _location = "Fetching Location...";
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      try {
        LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        );

        Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings,
        );

        setState(() {
          _location = "Lat: ${position.latitude}, Long: ${position.longitude}";
        });
      } catch (e) {
        setState(() {
          _location = "Error fetching location: $e";
        });
      }
    } else {
      setState(() {
        _location = "Location permission denied. Please enable it in settings.";
      });
    }
  }

  void _onSOSButtonPressed() {
    SOSHelper.sendSOS(context);
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Avoid redundant navigation.

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {

      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MapSelectionPage()))
            .then((_) => setState(() => _selectedIndex = 1));
        break;
      case 1:
        break;
      case 2:
        _onSOSButtonPressed();
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>  ProfileScreen()));},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _location,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  GridButton(label: 'View Problems', icon: Icons.report_problem,onPressed: (){},),
                  GridButton(label: 'Chat Other Admins', icon: Icons.chat,onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const Chatwithotheradmins()));
                  },),
                  GridButton(label: 'Create Plan', icon: Icons.add_chart,onPressed: (){},),
                  GridButton(label: 'Compare Models', icon: Icons.compare,onPressed: (){
                    Navigator.push((context),MaterialPageRoute(builder: (context)=> DisasterComparisonScreen()));

                  },),
                  GridButton(label: 'Community Demographics', icon: Icons.people,onPressed: (){
                     // Navigator.push((context),MaterialPageRoute(builder: (context)=> const DisasterFeed()));
                  },),
                  GridButton(label: 'Area Details', icon: Icons.location_city,onPressed: (){
                    Navigator.push((context), MaterialPageRoute(builder: (context)=> PowerBIWebView()));
                  },),

                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 63, 181, 120),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [

          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'SOS'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}


class GridButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const GridButton(
      {super.key, required this.label, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
class SOSHelper {
  static Future<void> sendSOS(BuildContext context) async {
    try {
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      if (context.mounted) {
        final snackBar = SnackBar(
          content: Text('SOS triggered! Location: Lat: ${position.latitude}, Long: ${position.longitude}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      if (context.mounted) {
        final snackBar = SnackBar(content: Text('Error getting location: $e'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}