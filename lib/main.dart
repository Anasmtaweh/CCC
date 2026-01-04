import 'package:flutter/material.dart';
import 'page1.dart';
import 'plate_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Care Check',
      theme: ThemeData(useMaterial3: true),
      home: const PlateLoginPage(),
    );
  }
}
