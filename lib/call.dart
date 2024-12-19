import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactLocalAuthorityPage extends StatelessWidget {
  const ContactLocalAuthorityPage({super.key});

  final List<Map<String, String>> _authorityContacts = const [
    {'name': 'Gautam Dua', 'phone': '8791438023'},
    {'name': 'Vishal Sharma', 'phone': '6398692585'},
    {'name': 'Yash Gupta', 'phone': '9520102418'},
  ];

  Future<void> _callNumber(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        title: const Text('Contact Local Authority'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _authorityContacts.length,
        itemBuilder: (context, index) {
          final contact = _authorityContacts[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 63, 181, 120),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                contact['name']!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                contact['phone']!,
                style: const TextStyle(color: Colors.blue),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () => _callNumber(contact['phone']!),
              ),
              onTap: () => _callNumber(contact['phone']!),
            ),
          );
        },
      ),
    );
  }
}
