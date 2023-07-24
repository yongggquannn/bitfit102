import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String _name = '';
  String _bio = '';
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveProfileData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase Storage
      if (_image != null) {
        final storage = FirebaseStorage.instance;
        final Reference storageReference =
            storage.ref().child('user_profiles/$_name.jpg');
        final UploadTask uploadTask = storageReference.putFile(_image!);
        await uploadTask.whenComplete(() => print('Image uploaded'));
      }

      // Save user data to Cloud Firestore
      final userData = {
        'name': _name,
        'bio': _bio,
        // Add other user details here if needed
      };

      await FirebaseFirestore.instance
          .collection('user_profiles')
          .doc(_name)
          .set(userData);

      // Save user data to shared_preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('name', _name);
      prefs.setString('bio', _bio);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile data saved successfully')),
      );
    } catch (error) {
      print('Error saving profile data: $error');
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error saving profile data')),
      );
    }
  }

  Future<void> _fetchProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _name = prefs.getString('name') ?? '';
        _bio = prefs.getString('bio') ?? '';
        _nameController.text = _name;
        _bioController.text = _bio;
      });
    } catch (error) {
      print('Error fetching profile data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _getImage();
                  });
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.add_a_photo, size: 50, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                onChanged: (value) {
                  setState(() {
                    _bio = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveProfileData,
                child: _isLoading ? const CircularProgressIndicator() : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
