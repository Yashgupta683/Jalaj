// /models/disaster_model.dart
class Disaster {
  final String title;
  final String state;
  final int year;

  Disaster({required this.title, required this.state, required this.year});

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
      title: json['declarationTitle'] ?? 'Unknown',
      state: json['state'] ?? 'N/A',
      year: json['declarationYear'] ?? 0,
    );
  }
}
