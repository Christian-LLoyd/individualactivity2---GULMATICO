import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditStudentScreen extends StatefulWidget {
  final Map<String, dynamic> student;

  const EditStudentScreen({required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _courseController;
  late String _year;
  late bool _enrolled;

  final List<String> _yearOptions = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
    'Fifth Year'
  ];

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.student['firstname']);
    _lastNameController =
        TextEditingController(text: widget.student['lastname']);
    _courseController = TextEditingController(text: widget.student['course']);
    _year = widget.student['year'] ?? 'First Year';
    _enrolled = widget.student['enrolled'] ?? false;
  }

  Future<void> _updateStudent() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.put(
        Uri.parse(
            'https://testing-backend-wnrj.onrender.com/api/students/${widget.student['_id']}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Firstname': _firstNameController.text,
          'Lastname': _lastNameController.text,
          'Year': _year,
          'Course': _courseController.text,
          'Enrolled': _enrolled,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        print('Failed to update student');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF3E7), // Soft retro beige
      appBar: AppBar(
        backgroundColor: Color(0xFFDFB13E), // Mustard yellow
        title: Text('Edit Student', style: TextStyle(fontFamily: 'Bungee')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442)), // Teal text
                  filled: true,
                  fillColor: Color(0xFFEAE3D2), // Light beige background
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _year,
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
                items: _yearOptions.map((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _year = newValue ?? 'First Year';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a year';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _courseController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the course';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SwitchListTile(
                title: Text('Enrolled', style: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442))),
                value: _enrolled,
                activeColor: Color(0xFFDFB13E), // Mustard yellow
                onChanged: (value) {
                  setState(() {
                    _enrolled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDFB13E), // Mustard yellow
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _updateStudent,
                child: Text('Update Student', style: TextStyle(fontFamily: 'Bungee')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
