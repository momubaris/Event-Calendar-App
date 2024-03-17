import 'dart:async';
import 'package:event_management/views/userdashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_management/views/login.dart';

class SessionHandler extends StatefulWidget {
  @override
  _SessionHandlerState createState() => _SessionHandlerState();
}

class _SessionHandlerState extends State<SessionHandler> {
  late SharedPreferences _prefs;
  bool _isLoggedIn = false;
  late Timer _sessionTimer;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _startSessionTimer();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    setState(() {});
  }

  void _startSessionTimer() {
    const sessionTimeout = Duration(minutes: 5);
    _sessionTimer = Timer(sessionTimeout, () {
      _logout();
      _navigateToLogin();
    });
  }

  void _logout() {
    // Perform logout actions, clear authentication token, etc.
    _prefs.setBool('isLoggedIn', false);
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? UserDashboard() : LoginPage();
  }
}
