import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _year = '';
  String _course = '';
  bool _enrolled = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> formData = {
        'Firstname': _firstName,
        'Lastname': _lastName,
        'Year': _year,
        'Course': _course,
        'Enrolled': _enrolled,
      };

      final response = await http.post(
        Uri.parse('https://testing-backend-wnrj.onrender.com/api/students'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(formData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Form submitted successfully');
      } else {
        print('Failed to submit form');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF3E7), // Retro soft beige background
      appBar: AppBar(
        backgroundColor: Color(0xFFDFB13E), // Mustard yellow
        title: Text('Retro Student Form', style: TextStyle(fontFamily: 'Bungee')),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442)), // Teal
                  filled: true,
                  fillColor: Color(0xFFEAE3D2), // Light retro beige
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSaved: (value) {
                  _firstName = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442)),
                  filled: true,
                  fillColor: Color(0xFFEAE3D2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSaved: (value) {
                  _lastName = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Year',
                  labelStyle: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442)),
                  filled: true,
                  fillColor: Color(0xFFEAE3D2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  DropdownMenuItem(value: 'First Year', child: Text('First Year')),
                  DropdownMenuItem(value: 'Second Year', child: Text('Second Year')),
                  DropdownMenuItem(value: 'Third Year', child: Text('Third Year')),
                  DropdownMenuItem(value: 'Fourth Year', child: Text('Fourth Year')),
                  DropdownMenuItem(value: 'Fifth Year', child: Text('Fifth Year')),
                ],
                onChanged: (value) {
                  setState(() {
                    _year = value!;
                  });
                },
                onSaved: (value) {
                  _year = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your academic year';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Course',
                  labelStyle: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442)),
                  filled: true,
                  fillColor: Color(0xFFEAE3D2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSaved: (value) {
                  _course = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your course';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SwitchListTile(
                title: Text('Enrolled', style: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442))),
                value: _enrolled,
                activeColor: Color(0xFFDFB13E),
                onChanged: (bool value) {
                  setState(() {
                    _enrolled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A3442), // Dark teal text
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submitForm,
                child: Text('Submit', style: TextStyle(fontFamily: 'Bungee')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
