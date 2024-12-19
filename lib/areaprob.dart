import 'package:flutter/material.dart';
import 'package:untitled/upl.dart';

class AreaProblemPage extends StatefulWidget {
  const AreaProblemPage({super.key});

  @override
  AreaProblemPageState createState() => AreaProblemPageState();
}

class AreaProblemPageState extends State<AreaProblemPage> {
  List<String> areaProblems = []; // List of problems (Initially empty)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area Wise Problems'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the problems or a message if no problems are uploaded
            areaProblems.isEmpty
                ? const Center(
              child: Text(
                'No problem uploaded yet.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: areaProblems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        areaProblems[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Navigation button to go to the UploadProblemPage
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Navigate to the UploadProblemPage and wait for the problem to be added
                final newProblem = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadProblemPage()),
                );

                if (newProblem != null) {
                  setState(() {
                    areaProblems.add(newProblem);
                  });
                }
              },
              child: const Text('Go to Upload Problem Page'),
            ),
          ],
        ),
      ),
    );
  }
}
