import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatelessWidget {
  final String eventId;

  const RegistrationPage({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Registration',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              RegistrationForm(
                eventId: eventId,
                onSubmit: (formData) => _submitRegistration(context, formData),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Method to submit the registration details
  void _submitRegistration(
      BuildContext context, Map<String, String> formData) async {
    try {
      // Get the current user's email
      User? user = FirebaseAuth.instance.currentUser;
      String? email = user?.email;

      // Add the user's email to the registration data
      formData['email'] = email!;

      // Store the registration details in Firestore
      await FirebaseFirestore.instance.collection('registrations').add({
        'eventId': eventId,
        ...formData,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration successful'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error submitting registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error submitting registration. Please try again later.'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}

class RegistrationForm extends StatefulWidget {
  final String eventId;
  final Function(Map<String, String>) onSubmit;

  const RegistrationForm(
      {Key? key, required this.eventId, required this.onSubmit})
      : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _enrollmentController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _enrollmentController,
            decoration: InputDecoration(
              labelText: 'Enrollment Number',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your enrollment number';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _courseController,
            decoration: InputDecoration(
              labelText: 'Course',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your course';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _semesterController,
            decoration: InputDecoration(
              labelText: 'Semester',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your semester';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
              ),
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Map<String, String> formData = {
        'name': _nameController.text,
        'enrollmentNumber': _enrollmentController.text,
        'course': _courseController.text,
        'semester': _semesterController.text,
      };
      widget.onSubmit(formData);
      _clearForm();
    }
  }

  void _clearForm() {
    _nameController.clear();
    _enrollmentController.clear();
    _courseController.clear();
    _semesterController.clear();
  }
}

void main() {
  var eventId = 'eventId'; // Replace with your actual event ID
  runApp(MaterialApp(
    home: RegistrationPage(eventId: eventId),
  ));
}
