import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Student {
  String fname;
  String lname;
  String classes;
  String major;

  Student({
    required this.fname, 
    required this.lname, 
    required this.classes, 
    required this.major
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Siswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentListPage(),
    );
  }
}

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _classesController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  List<Student> students = [];

  void _addStudent() {
    if (_validateInput()) {
      setState(() {
        students.add(Student(
          fname: _firstNameController.text,
          lname: _lastNameController.text,
          classes: _classesController.text,
          major: _majorController.text,
        ));
        _clearControllers();
      });
    }
  }

  bool _validateInput() {
    return _firstNameController.text.isNotEmpty &&
           _lastNameController.text.isNotEmpty &&
           _classesController.text.isNotEmpty &&
           _majorController.text.isNotEmpty;
  }

  void _clearControllers() {
    _firstNameController.clear();
    _lastNameController.clear();
    _classesController.clear();
    _majorController.clear();
  }

  void _deleteStudent(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus siswa ini?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                setState(() {
                  students.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditBottomSheet(int index) {
    final student = students[index];
    final firstNameController = TextEditingController(text: student.fname);
    final lastNameController = TextEditingController(text: student.lname);
    final classesController = TextEditingController(text: student.classes);
    final majorController = TextEditingController(text: student.major);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: classesController,
                decoration: InputDecoration(labelText: 'Classes'),
              ),
              TextField(
                controller: majorController,
                decoration: InputDecoration(labelText: 'Major'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    students[index] = Student(
                      fname: firstNameController.text,
                      lname: lastNameController.text,
                      classes: classesController.text,
                      major: majorController.text,
                    );
                  });
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manajemen Siswa')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _classesController,
                decoration: InputDecoration(
                  labelText: 'Classes',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _majorController,
                decoration: InputDecoration(
                  labelText: 'Major',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addStudent,
                child: Text('Add Student'),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return ListTile(
                    title: Text('${student.fname} ${student.lname}'),
                    subtitle: Text('${student.classes} - ${student.major}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showEditBottomSheet(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteStudent(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}