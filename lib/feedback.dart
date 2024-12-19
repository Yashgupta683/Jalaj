import 'package:flutter/material.dart';

class SubmitFeedbackPage extends StatefulWidget {
  const SubmitFeedbackPage({super.key});

  @override
  State<SubmitFeedbackPage> createState() => _SubmitFeedbackPageState();
}

class _SubmitFeedbackPageState extends State<SubmitFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final feedbackController = TextEditingController();
  String? _serviceRating;
  String? _recommendation;
  String? _appPerformance;
  String? _problemSolved;
  bool _isSubmitting = false;

  void _submitFeedback() {
    if (!_formKey.currentState!.validate()) {
      return; // Stop if form validation fails
    }

    setState(() {
      _isSubmitting = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form
      feedbackController.clear();
      setState(() {
        _serviceRating = null;
        _recommendation = null;
        _appPerformance = null;
        _problemSolved = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        title: const Text('Submit Feedback'),
      ),
      body: _isSubmitting
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1. How would you rate our service?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: ['Excellent', 'Good', 'Average', 'Poor']
                    .map((rating) => RadioListTile<String>(
                  title: Text(rating),
                  value: rating,
                  groupValue: _serviceRating,
                  onChanged: (value) {
                    setState(() {
                      _serviceRating = value;
                    });
                  },
                ))
                    .toList(),
              ),
              if (_serviceRating == null)
                const Text(
                  'Please select a rating.',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              const Text(
                '2. Would you recommend us to others?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: ['Yes', 'No']
                    .map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _recommendation,
                  onChanged: (value) {
                    setState(() {
                      _recommendation = value;
                    });
                  },
                ))
                    .toList(),
              ),
              if (_recommendation == null)
                const Text(
                  'Please select an option.',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              const Text(
                '3. How was the app performance?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: ['Fast', 'Moderate', 'Slow']
                    .map((performance) => RadioListTile<String>(
                  title: Text(performance),
                  value: performance,
                  groupValue: _appPerformance,
                  onChanged: (value) {
                    setState(() {
                      _appPerformance = value;
                    });
                  },
                ))
                    .toList(),
              ),
              if (_appPerformance == null)
                const Text(
                  'Please select an option.',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              const Text(
                '4. Was your problem resolved using the app?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: ['Yes', 'Partially', 'No']
                    .map((response) => RadioListTile<String>(
                  title: Text(response),
                  value: response,
                  groupValue: _problemSolved,
                  onChanged: (value) {
                    setState(() {
                      _problemSolved = value;
                    });
                  },
                ))
                    .toList(),
              ),
              if (_problemSolved == null)
                const Text(
                  'Please select an option.',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              const Text(
                '5. Additional Comments:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Write your feedback here...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide some comments.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    backgroundColor: const Color.fromARGB(255, 63, 181, 120),
                  ),
                  child: const Text('Submit Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
