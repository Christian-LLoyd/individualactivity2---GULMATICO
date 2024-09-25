import 'package:flutter/material.dart';
import 'package:individualactivity2/screens/edit_student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _students = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://testing-backend-wnrj.onrender.com/api/students'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _students = json.decode(response.body);
      });
    } else {
      print('Failed to load data');
    }
  }

  Future<void> deleteStudent(String id) async {
    final response = await http.delete(
      Uri.parse('https://testing-backend-wnrj.onrender.com/api/students/$id'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _students.removeWhere((student) => student['_id'] == id);
      });
    } else {
      print('Failed to delete student');
    }
  }

  void editStudent(Map<String, dynamic> student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStudentScreen(student: student),
      ),
    );

    if (result ?? false) {
      // Refresh the data if the student was updated
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF3E7), // Soft retro beige
      appBar: AppBar(
        backgroundColor: Color(0xFFDFB13E), // Mustard yellow
        title: Text('Student List', style: TextStyle(fontFamily: 'Bungee')),
        centerTitle: true,
      ),
      body: _students.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                String id = _students[index]['_id'] ?? '';
                String firstName = _students[index]['Firstname'] ?? '';
                String lastName = _students[index]['Lastname'] ?? '';
                String year = _students[index]['Year'] ?? 'Unknown';
                String course = _students[index]['Course'] ?? 'Unknown';
                bool enrolled = _students[index]['Enrolled'] ?? false;

                return Dismissible(
                  key: Key(id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Color(0xFFDAA520), // Burnt orange for delete swipe
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    deleteStudent(id);
                  },
                  child: GestureDetector(
                    onTap: () => editStudent(_students[index]),
                    child: Card(
                      color: Color(0xFFEAE3D2), // Light retro beige for cards
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$firstName $lastName',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Bungee',
                                color: Color(0xFF0A3442), // Teal color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Year: $year, Course: $course',
                              style: TextStyle(fontFamily: 'Bungee', color: Color(0xFF0A3442)),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  enrolled ? 'Enrolled' : 'Not Enrolled',
                                  style: TextStyle(
                                    color: enrolled ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Bungee',
                                  ),
                                ),
                                Spacer(),
                                enrolled
                                    ? Icon(Icons.check, color: Colors.green)
                                    : Icon(Icons.close, color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
