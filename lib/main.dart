import 'package:flutter/material.dart';
import 'kidi-makodo-app-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kidi-Makodo-App',
      home: KidiMakodoApp(),
      );
  }
}
