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
  final Map<int, List<Offset>> _fingers = {};
  final int MAXTRAITPOINT = 150;                   //15 points trong trait
  final int MAX_CIRCLE_SIZE = 30;                 //px

  Map<int, Offset> _extractCurrentPoints() {            //Lấy điểm cuối cùng trong chuỗi 15 điểm gần nhất
    Map<int, Offset> currentPoints = {};
    _fingers.forEach((id, trail) {
      currentPoints[id] = trail.last;                   //với mỗi ID của ngón tay chỉ lấy điểm cuối cùng
    });
    
    return currentPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      //Bắt buộc phải có
      behavior: HitTestBehavior.opaque,
      
      //Khi nhấn 1 ngón
      onPointerDown: (PointerDownEvent event) {
        if (_fingers.length < 3) {
          setState(() {
            _fingers[event.pointer] = [event.localPosition];
          });
          widget.onUpdate(_extractCurrentPoints());                         //chỉ lẩy diểm cuối cùng trong tập hợp 15 điểm gần nhất
        }
      },
      
      // Khi ngón tay di chuyển
      onPointerMove: (PointerMoveEvent event) {
        if (_fingers.containsKey(event.pointer)) {
          setState(() {
            // List<Offset> trail;
            // if (_fingers[event.pointer] == null) {
            //   trail = [];
            // }
            // else {
            //   trail = _fingers[event.pointer]!;
            // }
            List<Offset> trail = _fingers[event.pointer] ?? [];     //cơ chế Null Safety của ngôn ngữ Dart
            trail.add(event.localPosition);
            if (trail.length > 15) {
              trail.removeAt(0);
            }
          });
          widget.onUpdate(_extractCurrentPoints());
        }
      },
      
      // Khi ngón tay nhấc lên
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          _fingers.remove(event.pointer);
        });
        widget.onUpdate(_extractCurrentPoints());
      },

      //Khi bị cancel
      onPointerCancel: (PointerCancelEvent event) {
        setState(() {
          _fingers.remove(event.pointer);
        });
        widget.onUpdate(_extractCurrentPoints());
      },

      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255,228,244,252), //Màu nền
        child: Stack(
          children: [            
            // Vẽ hình tròn thể hiện các điểm trên màn hình
            ..._fingers.entries.map((entry) => _buildFingerTrail(entry.key, entry.value)),
          ],
        ),
      ),
    );
  }

  // Widget _buildTouchIndicator(int id, Offset position) {
  //   return Positioned(
  //     left: position.dx - 25,
  //     top: position.dy - 25,
  //     child: Column(
  //       children: [
  //         Container(
  //           width: 50,
  //           height: 50,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             gradient: RadialGradient(
  //               // stops: [0.5, 0.5, 0.5],
  //               colors: [
  //                 Color.fromARGB(255,251,251,251),
  //                 Color.fromARGB(255,255,163,34),
  //                 Color.fromARGB(255,187,20,20),
  //                 Color.fromARGB(255, 0, 58, 107),
  //                 // Color.fromARGB(),
  //                 // Color.fromARGB(),
  //                 // Color.fromARGB(),
  //                 // Color.fromARGB(),
  //               ]
  //             ),
  //             border: Border.all(color: Color.fromARGB(255, 0, 58, 107), width: 2),
  //             //color: Color.fromARGB(100, 0, 58, 107),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFingerTrail(int id, List<Offset> trail) {
    // Nếu không có điểm nào thì không vẽ gì (kiểm tra an toàn)
    if (trail.isEmpty) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }

    // Vẽ hình tròn và đuôi
    return Stack(
      children: [
        for (int i = 0; i < trail.length - 1; i++)
          _buildCircle(trail[i], (i+1) / trail.length, (i+1)*MAX_CIRCLE_SIZE / trail.length,isHead: false), //Đuôi
        _buildCircle(trail.last, 1.0, MAX_CIRCLE_SIZE*1.0, isHead: true),                                   //Đầu
      ],
    );


    
  }

  Widget _buildCircle(Offset position, double opacity, double diameter, {bool isHead = false}) {

    // Căn chỉnh tâm hình tròn là tọa độ position
    double leftOffset = position.dx - (diameter / 2);
    double topOffset = position.dy - (diameter / 2);

    // 4. Trả về Widget Positioned
    if (isHead == false) {
      return Positioned(
        left: leftOffset,
        top: topOffset,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 0, 58, 107),
          ),
        ),
      );
    }
    else {
      return Positioned(
        left: leftOffset,
        top: topOffset,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            gradient: RadialGradient(
              // stops: [0.5, 0.5, 0.5],
              colors: [
                Color.fromARGB(255,251,251,251),
                Color.fromARGB(255,255,163,34),
                Color.fromARGB(255,187,20,20),
                Color.fromARGB(255, 0, 58, 107),
                // Color.fromARGB(),
                // Color.fromARGB(),
                // Color.fromARGB(),
                // Color.fromARGB(),
              ]
            ),

            border: Border.all(color: Color.fromARGB(255, 0, 58, 107), width: 2.0),
            // - Thêm hiệu ứng bóng đổ (Glow)
            boxShadow: [
              if (isHead)
                BoxShadow(
                  color: Color.fromARGB(255,255,163,34),
                  blurRadius: 12,
                  spreadRadius: 3,
                )
            ],
          ),
        ),
      );
    }
    
  }
}