import 'package:event_management/firebase_options.dart';
import 'package:event_management/views/onboarding_screen.dart';
import 'package:event_management/views/userdashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Check if the user is logged in or not
      future: isLoggedIn(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.data!) {
            // User is logged in, navigate to user dashboard
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: GoogleFonts.latoTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: UserDashboard(),
            );
          } else {
            // User is not logged in, navigate to onboarding or login screen
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: GoogleFonts.latoTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: OnboardingScreen(),
            );
          }
        }
      },
    );
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
