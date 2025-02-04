import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  String? _savedName;
  String? _savedContact;
  File? _savedImage;
  bool _isEditing = true;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    setState(() {
      _savedName = _nameController.text.isNotEmpty ? _nameController.text : _savedName;
      _savedContact = _contactController.text.isNotEmpty ? _contactController.text : _savedContact;
      _savedImage = _image ?? _savedImage;
      _isEditing = false; // Hide input fields after saving
    });
  }

  void _editProfile() {
    setState(() {
      _isEditing = true; // Show input fields for editing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        actions: [
          if (_savedImage != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                backgroundImage: FileImage(_savedImage!),
              ),
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isEditing || _savedImage == null)
                GestureDetector(
                  onTap: _isEditing ? _pickImage : null,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              SizedBox(height: 20),

              if (_isEditing) ...[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Contact Info",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text("Save Profile"),
                ),
              ] else ...[
                if (_savedImage != null)
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(_savedImage!),
                  ),
                SizedBox(height: 20),
                Text(
                  _savedName ?? "No Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  _savedContact ?? "No Contact Info",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _editProfile,
                  child: Text("Edit Profile"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
