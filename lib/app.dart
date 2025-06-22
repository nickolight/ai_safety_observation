import 'package:flutter/material.dart';
import 'presentation/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Safety Observation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeView(),
    );
  }
}
