import 'package:flutter/material.dart';

class CustomGuidelinesPage extends StatefulWidget {
  const CustomGuidelinesPage({super.key});

  @override
  CustomGuidelinesPageState createState() => CustomGuidelinesPageState();
}

class CustomGuidelinesPageState extends State<CustomGuidelinesPage> {
  bool _isChecked = false; // Variable to track checkbox state

  final List<Map<String, dynamic>> _guidelines = const [
    {
      'title': 'Risk Assessment',
      'content': [
        'Identify potential disasters: Floods, earthquakes, hurricanes, wildfires, etc.',
        'Evaluate vulnerability: Assess the area\'s geography, infrastructure, and community preparedness.',
        'List critical resources: Hospitals, shelters, and emergency service locations.',
      ],
    },
    {
      'title': 'Preparation Plan',
      'content': [
        'Emergency Contacts: Maintain a list of emergency numbers (local government, rescue teams, and hospitals).',
        'Go Bags:',
        '  - Water (at least 3-day supply per person).',
        '  - Non-perishable food.',
        '  - First-aid kit and essential medicines.',
        '  - Flashlight and extra batteries.',
        '  - Multi-purpose tool.',
        '  - Copies of important documents (IDs, insurance, deeds) in waterproof containers.',
        '  - Cash in small denominations.',
        '  - Emergency blankets and clothing.',
        'Evacuation Plan: Mark safe routes and identify shelters.',
        'Communication Plan: Agree on family meeting points and out-of-town emergency contacts.',
        'Skill Development: Train in CPR, first aid, and basic survival skills.',
      ],
    },
    {
      'title': 'Early Warning and Monitoring',
      'content': [
        'Sign up for alerts: Local government and weather apps.',
        'Monitor risks: Keep updated on news and weather reports.',
        'Emergency Alarms: Install fire, smoke, and carbon monoxide detectors.',
      ],
    },
    {
      'title': 'During the Disaster',
      'content': [
        'Stay Informed: Follow official instructions from authorities.',
        'Protective Actions:',
        '  - Flood: Move to higher ground, avoid flooded areas.',
        '  - Earthquake: Drop, cover, and hold on.',
        '  - Fire: Use escape routes, stay low to avoid smoke.',
        'Communication: Update emergency contacts on your status.',
        'Avoid Risks: Do not use damaged structures or utilities.',
      ],
    },
    {
      'title': 'After the Disaster',
      'content': [
        'Safety Check:',
        '  - Ensure all family members are accounted for.',
        '  - Avoid entering damaged buildings.',
        'Health Precautions:',
        '  - Avoid contaminated water or food.',
        '  - Seek medical attention for injuries.',
        'Aid and Recovery:',
        '  - Report to relief agencies for assistance.',
        '  - Document damage for insurance claims.',
        'Community Support: Help neighbors, especially the elderly and disabled.',
      ],
    },
    {
      'title': 'Special Considerations',
      'content': [
        'For Children: Include comfort items like toys or books.',
        'For Pets: Pack pet food, leashes, and vaccination records.',
        'For Disabilities: Customize kits with necessary medical devices and supplies.',
        'For Remote Areas: Ensure alternative power sources and communication tools like satellite phones.',
      ],
    },
    {
      'title': 'Practice and Review',
      'content': [
        'Conduct regular drills to ensure everyone knows the plan.',
        'Update supplies and contacts biannually.',
        'Evaluate past disaster responses to improve the plan.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        title: const Text('Custom Disaster Guidelines'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._guidelines.map((section) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 2, // Light shadow for cards
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(
                            (section['content'] as List<String>).length,
                                (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                section['content'][index],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              // Checkbox and button at the bottom
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  const Text(
                    'I understand the guidelines',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isChecked
                    ? () {
                  Navigator.pop(context); // Navigate back to the home page
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Go Back to Home',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
