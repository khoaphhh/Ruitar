import 'package:flutter/material.dart';
import 'package:ruitar/logic/template_store.dart';
import 'package:ruitar/logic/chord_record.dart';
import 'ui/touch_detector.dart';
import 'logic/calc_methods.dart';
import 'package:ruitar/ui/guitar_strings.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

// 1. Đổi thành StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TemplateStore store;
  String detectedChord = "none";

  @override
  void initState() {
    super.initState();
    store = TemplateStore();
    store.loadTemplates(); 
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,// chiếm 3/4 màn hình
            child: Stack(
              children: [
                TouchDetector(
                  onUpdate: (points) { 
                    if (points.isEmpty || points.length == 1 || points.length >=5) {
                        setState(() {
                          detectedChord = "none";
                        });
                      return;
                    }

                    if (points.length >= 2 && points.length <= 4) {
                      ChordRecord? nearestChord;
                      List<Offset>? inputVector = convertToVector(points);
                      if (inputVector == null) {
                        return;
                      }
                      else {
                        nearestChord = store.store.findNearest(inputVector);
                        if (nearestChord == null) {
                          return;
                        }
                        else {
                          setState(() {
                            detectedChord = nearestChord!.chordName;
                          });
                        }
                      }
                    }
                  },
                ),
                Positioned(
                  top: 100,
                  left: 220,
                  child: IgnorePointer(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Color.fromARGB(100, 255, 255, 255),
                      child: Text(
                        "Hợp âm: $detectedChord",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider(
          //   height: 1,       // Chiều cao không gian chứa đường kẻ
          //   thickness: 2,    // Độ dày của đường kẻ
          //   color: Color.fromARGB(100, 255, 255, 255), // Màu sắc
          // ),

          Expanded(
            flex: 1,
            child: GuitarStrings(
              onCellTapped: (int cellIndex) {
                print('tín hiệu ở ô số: $cellIndex');
              },
            ),
          ),
        ],
      ),
    );
  }
}