// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../services/api_service.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FEMA Disaster Data',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: DisasterChartScreen(),
//     );
//   }
// }
//
// class DisasterChartScreen extends StatefulWidget {
//   @override
//   _DisasterChartScreenState createState() => _DisasterChartScreenState();
// }
//
// class _DisasterChartScreenState extends State<DisasterChartScreen> {
//   List<Map<String, dynamic>> _disasterData = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }
//
//   Future<void> _fetchData() async {
//     var data = await APIService.fetchDisasters();
//     setState(() {
//       _disasterData = _processData(data);
//     });
//   }
//
//   List<Map<String, dynamic>> _processData(List<dynamic> data) {
//     Map<String, int> disasterCount = {};
//
//     for (var item in data) {
//       String type = item['incidentType'] ?? 'Unknown';
//       disasterCount[type] = (disasterCount[type] ?? 0) + 1;
//     }
//
//     return disasterCount.entries.map((e) => {'type': e.key, 'count': e.value}).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('FEMA Disaster Data')),
//       body: _disasterData.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Disaster Types by Count', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 16),
//             Expanded(child: _buildPieChart()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPieChart() {
//     return PieChart(
//       PieChartData(
//         sections: _disasterData.map((data) {
//           return PieChartSectionData(
//             title: '${data['type']}\n(${data['count']})',
//             value: data['count'].toDouble(),
//             color: Colors.primaries[_disasterData.indexOf(data) % Colors.primaries.length],
//             radius: 80,
//           );
//         }).toList(),
//         sectionsSpace: 2,
//         centerSpaceRadius: 40,
//       ),
//     );
//   }
// }
