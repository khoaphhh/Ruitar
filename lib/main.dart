import 'package:flutter/material.dart';
import 'package:ruitar/logic/template_store.dart';
import 'package:ruitar/logic/chord_record.dart';
import 'ui/touch_detector.dart';
import 'logic/calc_methods.dart';
import 'package:ruitar/ui/guitar_strings.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MaterialApp(home: HomeScreen()));
} 

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
                Stack(
                  children: [
                    IgnorePointer(        //không cản màn hình cảm ứng
                      child: Center(      //căn chính giữa màn hình
                        child: Padding(   // dịch xuống
                          padding: EdgeInsets.only(top: 450),
                          child: Text(
                            "$detectedChord",
                            style: const TextStyle(
                              fontFamily: 'RobotoCondensed',
                              color: Color.fromARGB(200, 255, 255, 255),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
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
              onUpdate: (cells) {
                // print(cells);
              },
            ),
          ),
        ],
      ),
    );
  }
}