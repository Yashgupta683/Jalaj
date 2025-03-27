// /screens/disaster_feed.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/disaster_model.dart';

class DisasterFeed extends StatefulWidget {
  const DisasterFeed({super.key});

  @override
  _DisasterFeedState createState() => _DisasterFeedState();
}

class _DisasterFeedState extends State<DisasterFeed> {
  List<Disaster> disasters = [];

  @override
  void initState() {
    super.initState();
    loadDisasters();
  }

  Future<void> loadDisasters() async {
    var response = await api_service.fetchDisasters();
    setState(() {
      disasters = response.map((d) => Disaster.fromJson(d)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Disaster Feed")),
      body: disasters.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: disasters.length,
        itemBuilder: (context, index) {
          var disaster = disasters[index];
          return ListTile(
            title: Text(disaster.title),
            subtitle: Text("State: ${disaster.state}"),
            trailing: Text("Year: ${disaster.year}"),
          );
        },
      ),
    );
  }
}
