import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class DisasterComparisonScreen extends StatefulWidget {
  const DisasterComparisonScreen({super.key});

  @override
  _DisasterComparisonScreenState createState() => _DisasterComparisonScreenState();
}

class _DisasterComparisonScreenState extends State<DisasterComparisonScreen> {
  String selectedDisaster = "Earthquake";
  String selectedModel = "";

  final List<String> disasters = ["Earthquake", "Flood", "Hurricane", "Wildfire"];

  final Map<String, Map<String, double>> modelData = {
    "Earthquake": {
      "Traditional Model": 3.5,
      "Kelly Model": 4.0,
      "PAR Model": 3.8,
      "Mitroff Model": 4.2,
    },
    "Flood": {
      "Manitoba Model": 4.2,
      "Crunch Model": 3.6,
      "Mitroff Model": 4.0,
      "PDCA Model": 3.9,
    },
    "Hurricane": {
      "PDCA Model": 3.9,
      "Integrated Model": 4.3,
      "Fink Model": 3.7,
      "Onion Model": 4.1,
    },
    "Wildfire": {
      "Risk Management Model": 4.1,
      "Wheel-Shape Model": 3.8,
      "Cuny Model": 4.2,
      "Iceberg Model": 3.9,
    },
  };

  final Map<String, String> modelDescriptions = {
    "Traditional Model": "A sequential approach to disaster phases.",
    "Kelly Model": "Emphasizes learning from real disasters.",
    "PAR Model": "Focuses on reducing disaster risk.",
    "Mitroff Model": "A proactive model emphasizing learning.",
    "Manitoba Model": "Balances preparation and resilience.",
    "Crunch Model": "A causal model explaining disaster causes.",
    "PDCA Model": "Plan-Do-Check-Act cycle for continuous improvement.",
    "Integrated Model": "Combines multiple aspects of disaster management.",
    "Fink Model": "Focuses on crisis analysis and prevention.",
    "Onion Model": "Framework for organizational crisis preparedness.",
    "Risk Management Model": "Enhances community resilience and risk reduction.",
    "Wheel-Shape Model": "Based on disaster life cycle stages.",
    "Cuny Model": "A complete cycle integrating various approaches.",
    "Iceberg Model": "Focuses on underlying structures in disaster management."
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compare Disaster Models')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedDisaster,
              items: disasters.map((disaster) {
                return DropdownMenuItem<String>(
                  value: disaster,
                  child: Text(disaster),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDisaster = value!;
                  selectedModel = "";
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        barGroups: modelData[selectedDisaster]!.entries.map((entry) {
                          return BarChartGroupData(
                            x: modelData[selectedDisaster]!.keys.toList().indexOf(entry.key),
                            barRods: [BarChartRodData(toY: entry.value, color: Colors.blue)],
                            showingTooltipIndicators: [0],
                          );
                        }).toList(),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    modelData[selectedDisaster]!.keys.elementAt(value.toInt()),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                );
                              },
                              reservedSize: 40,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      hint: Text("Select a model for more info"),
                      value: selectedModel.isNotEmpty ? selectedModel : null,
                      items: modelData[selectedDisaster]!.keys.map((model) {
                        return DropdownMenuItem<String>(
                          value: model,
                          child: Text(model),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedModel = value!;
                        });
                      },
                    ),
                  ),
                  if (selectedModel.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        modelDescriptions[selectedModel] ?? "No information available.",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
