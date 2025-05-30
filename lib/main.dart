import 'package:flutter/material.dart';
import 'package:clip_clop/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ClipClopApp());
}

class ClipClopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clip Clop',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF1A2B3C),       // Dark blue-gray
          secondary: Color(0xFF4A6B8A),     // Medium blue-gray
          surface: Color(0xFFF0F2F5),       // Light gray
          onPrimary: Colors.white,          // Text/icon color on primary
          onSurface: Colors.black87,        // Text color on surface
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1A2B3C),
          elevation: 4,
          titleTextStyle: TextStyle(
            color: Colors.white,            // Ensure app bar text is white
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,            // Ensure app bar icons are white
          ),
        ),
        textTheme: TextTheme(
          labelLarge: TextStyle(            // Replaces deprecated 'button'
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
