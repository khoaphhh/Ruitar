import 'package:flutter/material.dart';
import 'ui/touch_detector.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TouchDetector(
        onUpdate: (points) {          
        },
      ),
    );
  }
}


