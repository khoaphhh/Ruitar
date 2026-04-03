import 'package:flutter/material.dart';
import 'package:ruitar/logic/template_store.dart';
import 'package:ruitar/logic/chord_record.dart';
import 'ui/touch_detector.dart';
import 'logic/calc_methods.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TouchDetector(
        onUpdate: (points) {  
          // points.forEach((id, trail) {
          //   // trail là List<Offset> chứa 15 điểm
          //   print("Vị trí $id: ${trail.toString()}");   
          // });     
          
          TemplateStore store = TemplateStore();
          store.loadTemplates();

          List<double>? inputVector = convertToVector(points);

          ChordRecord? nearestChord;

          if (inputVector == null) print("no chord");
          else if (inputVector.length == 8) {
            nearestChord = store.store_2Points.findNearest(inputVector);
          }
          else if (inputVector.length == 16) {
            nearestChord = store.store_3Points.findNearest(inputVector);
          }
          else if (inputVector.length == 32) {
            nearestChord = store.store_4Points.findNearest(inputVector);
          }

          if (nearestChord == null) print("no chord");
          else print(nearestChord.chordName);
        },
      ),
    );
  }
}


