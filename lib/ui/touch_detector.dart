import 'package:flutter/material.dart';

typedef TouchCallback = void Function(Map<int, Offset> points);

class TouchDetector extends StatefulWidget {
  final TouchCallback onUpdate;

  const TouchDetector({super.key, required this.onUpdate});

  @override
  State<TouchDetector> createState() {
    return _TouchDetectorState();    
  }
}

class _TouchDetectorState extends State<TouchDetector> {
  final Map<int, Offset> _fingers = {};

  @override
  Widget build(BuildContext context) {
    return Listener(
      //Bắt buộc phải có
      behavior: HitTestBehavior.opaque,
      
      //Khi nhấn 1 ngón
      onPointerDown: (PointerDownEvent event) {
        if (_fingers.length < 3) {
          setState(() {
            _fingers[event.pointer] = event.localPosition;
          });
          widget.onUpdate(_fingers);
        }
      },
      
      // Khi ngón tay di chuyển
      onPointerMove: (PointerMoveEvent event) {
        if (_fingers.containsKey(event.pointer)) {
          setState(() {
            _fingers[event.pointer] = event.localPosition;
          });
          widget.onUpdate(_fingers);
        }
      },
      
      // Khi ngón tay nhấc lên
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          _fingers.remove(event.pointer);
        });
        widget.onUpdate(_fingers);
      },

      //Khi bị cancel
      onPointerCancel: (PointerCancelEvent event) {
        setState(() {
          _fingers.remove(event.pointer);
        });
        widget.onUpdate(_fingers);
      },

      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255,228,244,252), //Màu nền
        child: Stack(
          children: [
            // // Hiển thị số ngón tay
            // Positioned(
            //   top: 50,
            //   left: 20,
            //   child: Text(
            //     "Đang nhận diện: ${_fingers.length} ngón tay",
            //     style: const TextStyle(color: Color.fromARGB(255, 0, 58, 107), fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            
            // Vẽ các vòng tròn tại vị trí ngón tay chạm vào (Debug UI)
            ..._fingers.entries.map((entry) => _buildTouchIndicator(entry.key, entry.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildTouchIndicator(int id, Offset position) {
    return Positioned(
      left: position.dx - 25,
      top: position.dy - 25,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                // stops: [0.5, 0.5, 0.5],
                colors: [
                  Color.fromARGB(255,255,163,34),
                  Color.fromARGB(255,187,20,20),
                  Color.fromARGB(255, 0, 58, 107),
                  // Color.fromARGB(),
                  // Color.fromARGB(),
                  // Color.fromARGB(),
                  // Color.fromARGB(),
                ]
              ),
              border: Border.all(color: Color.fromARGB(255, 0, 58, 107), width: 2),
              //color: Color.fromARGB(100, 0, 58, 107),
            ),
          ),
        ],
      ),
    );
  }
}