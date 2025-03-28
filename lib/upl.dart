import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UploadProblemPage extends StatefulWidget {
  const UploadProblemPage({super.key});

  @override
  State<UploadProblemPage> createState() => _UploadProblemPageState();
}

class _UploadProblemPageState extends State<UploadProblemPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  String? _pdfFilePath;
  String? _savedPdfPath;
  bool _isSubmitting = false;

  // Function to pick PDF file
  void _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFilePath = result.files.single.path;
      });
    }
  }

  // Function to save PDF to parent directory
  Future<String> _savePDFToFolder(String originalPath) async {
    try {
      // Get the appropriate directory based on the platform
      Directory? saveDirectory;

      if (Platform.isAndroid) {
        // For Android, use external storage (requires permissions)
        saveDirectory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        // For iOS, use documents directory
        saveDirectory = await getApplicationDocumentsDirectory();
      } else {
        // Fallback for other platforms
        saveDirectory = await getTemporaryDirectory();
      }

      if (saveDirectory == null) {
        throw Exception('Could not find appropriate directory');
      }

      // Get the parent directory (up one level)
      final Directory parentDir = saveDirectory.parent;

      // Generate a unique filename using current timestamp
      String fileName = 'problem_${DateTime.now().millisecondsSinceEpoch}.pdf';
      String newPath = '${parentDir.path}/$fileName';

      // Copy the file to the new location
      File originalFile = File(originalPath);
      await originalFile.copy(newPath);

      return newPath;
    } catch (e) {
      print('Error saving file: $e');
      rethrow;
    }
  }

  // Function to submit the form
  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // Stop if form validation fails
    }

    if (_pdfFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a PDF file.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Save the PDF to parent directory
      _savedPdfPath = await _savePDFToFolder(_pdfFilePath!);

      // Simulate form submission delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      // Show success message with file details
      _showSubmissionDetailsDialog();

      // Clear the form
      titleController.clear();
      descriptionController.clear();
      locationController.clear();
      setState(() {
        _pdfFilePath = null;
      });
    } catch (e) {
      // Handle any errors during file saving
      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Show dialog with submission details
  void _showSubmissionDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Problem Submitted Successfully'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${titleController.text}'),
              Text('Location: ${locationController.text}'),
              Text('PDF Saved: ${_savedPdfPath?.split('/').last ?? 'N/A'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
        title: const Text('Upload Problem'),
      ),
      body: SafeArea(
        child: _isSubmitting
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Problem Title:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter problem title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Problem Description:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Describe the problem',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Upload PDF as Proof:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _pickPDF,
                    child: const Text('Upload PDF'),
                  ),
                  if (_pdfFilePath != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'PDF Selected: ${_pdfFilePath!.split('/').last}',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Text(
                    'Enter Location Manually:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      hintText: 'Enter location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Location is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 32.0,
                        ),

                        backgroundColor: const Color.fromARGB(255, 63, 181, 120),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }
}