import 'package:e_gov/screens/citizen/citizen_dashboard.dart';
import 'package:e_gov/screens/deptwoker/gov_worker_dashboard.dart';
import 'package:flutter/material.dart';
import './screens/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Gov',
      theme: ThemeData(
      
      ),
      home: const Wrapper()
    );
  }
}
