import 'package:flutter/material.dart';
import 'package:ruitar/logic/template_store.dart';
import 'package:ruitar/logic/chord_record.dart';
import 'ui/touch_detector.dart';
import 'logic/calc_methods.dart';


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
      body: Stack(
        children: [
          TouchDetector(
            onUpdate: (points) { 
              // 4. CHỐT CHẶN LUỒNG DỮ LIỆU
              if (points.length <= 1 || points.length > 4) {
                return; // Thoát ngay, không làm gì cả
              }
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

            },
          ),
          Positioned(
            top: 100, // Cách mép trên 50 pixel (tránh bị dính vào thanh trạng thái pin/wifi)
            left: 220, // Cách mép trái 20 pixel
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Color.fromARGB(144, 255, 255, 255),
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
    );
  }
}