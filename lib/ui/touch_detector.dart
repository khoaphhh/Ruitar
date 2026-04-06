import 'package:flutter/material.dart';
import '../models/trail_point.dart';
import '../painters/trail_painter.dart';


//typedef TouchCallback = void Function(Map<int, Offset> points);

class TouchDetector extends StatefulWidget {
  final Function(Map<int, Offset>) onUpdate;

  const TouchDetector({super.key, required this.onUpdate});

  @override
  State<TouchDetector> createState() {
    return _TouchDetectorState();    
  }
}

class _TouchDetectorState extends State<TouchDetector> with SingleTickerProviderStateMixin {      //SingleTickerProviderStateMixin để dùng vsync: this
  final Map<int, List<TrailPoint>> _fingers = {};
  late AnimationController _ticker;               // Khi khởi tạo _ticker và gọi hàm .repeat(), Mỗi lần gõ nhịp, sẽ gọi CustomPainter vẽ lại đuôi
  final Set<int> _activePointers = {};

  @override
  void initState() {                        //được gọi một lần duy nhất và không bao giờ chạy lại. Đây là nơi tiêu chuẩn và an toàn nhất để bạn khởi tạo các biến hoặc bộ điều khiển hoạt động độc lập với quá trình vẽ giao diện (như bộ đếm thời gian ticker).
    super.initState();
    // Ticker chạy liên tục làm nhịp đập cho CustomPainter
    _ticker = AnimationController(
      vsync: this,  //ngăn chặn các hoạt ảnh chạy ngầm tiêu tốn tài nguyên (như RAM, CPU) khi màn hình chứa widget này bị ẩn đi
      duration: const Duration(seconds: 1),       //biến _ticker.value sẽ chạy từ 0.0 lên 1.0 trong đúng 1 giây, sau đó reset về 0.0 và chạy lại.
    )..repeat();  //Hàm này ra lệnh cho bộ đếm chạy tuần hoàn vô tận yêu cầu CustomPainter vẽ lại màn hình
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _handlePointerDown(PointerEvent event) {
    setState(() {
      _activePointers.add(event.pointer); // Đánh dấu ngón này đang giữ
      if (_fingers.containsKey(event.pointer) == false) {
        _fingers[event.pointer] = []; 
      }
      _fingers[event.pointer]!.add(TrailPoint(event.localPosition, DateTime.now().millisecondsSinceEpoch));
      _triggerUpdate();
    });
    
  }

  void _handlePointerMove(PointerEvent event) {
    setState(() {
      if (_activePointers.contains(event.pointer)) {
        _fingers[event.pointer]!.add(TrailPoint(event.localPosition, DateTime.now().millisecondsSinceEpoch));
        _triggerUpdate();
      }
    });
  }

  void _handlePointerUp(PointerEvent event) {
    setState(() {
      _activePointers.remove(event.pointer); // chỉ bỏ đánh dấu đang giữ, KHÔNG xóa khỏi _fingers
      _triggerUpdate();
    });
    
  }

  // Hàm _triggerUpdate  chỉ lấy tọa độ của các ngón đang giữ
  void _triggerUpdate() {
    Map<int, Offset> currentPoints = {};
    for (int id in _activePointers) {
      if (_fingers[id] != null && _fingers[id]!.isNotEmpty) {
        currentPoints[id] = _fingers[id]!.last.position;
      }
    }
        
    widget.onUpdate(currentPoints);
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Offset> currentPoints = {};
    for (int id in _activePointers) {
      if (_fingers[id] != null && _fingers[id]!.isNotEmpty) {
        currentPoints[id] = _fingers[id]!.last.position;
      }
    }
    return Stack(
      children: [
        Listener(
          //Bắt buộc phải có
          behavior: HitTestBehavior.opaque,
          
          //Khi nhấn 1 ngón
          onPointerDown: _handlePointerDown,
          onPointerMove: _handlePointerMove,
          onPointerUp: _handlePointerUp,
          onPointerCancel: _handlePointerUp,

          child: Container(
            //color: Color.fromARGB(255,228,244,252),
            color: Color.fromARGB(255, 0, 0, 0),
            child: CustomPaint(
              painter: TrailPainter(
                fingers: _fingers,
                activePointers: _activePointers,
                repaint: _ticker, // Ticker ép Painter vẽ lại liên tục 60fps
                timeToLive: 300,  //set tốc độ shrink của đuôi
              ),
              size: Size.infinite,
            ),
          )
          
        ),


        // Positioned(
        //   top: 50, // Cách mép trên 50 pixel (tránh bị dính vào thanh trạng thái pin/wifi)
        //   left: 220, // Cách mép trái 20 pixel
        //   child: IgnorePointer(
        //     child: Container(
        //       padding: const EdgeInsets.all(8),
        //       color: Color.fromARGB(100, 255, 255, 255),
        //       child: Text(
        //         "Số ngón: (${_activePointers.length})",
        //         style: const TextStyle(
        //           color: Colors.white,
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   )
        // ),


        // if (_activePointers.isEmpty) 
        //   Positioned(
        //     top: 50, // Cách mép trên 50 pixel (tránh bị dính vào thanh trạng thái pin/wifi)
        //     left: 20, // Cách mép trái 20 pixel
        //     child: IgnorePointer(
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         color: Color.fromARGB(100, 255, 255, 255),
        //         child: Text(
        //           "Waiting for input...",
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       )
        //     ),
        //   ),
        
        
        // if (_activePointers.length == 1)
        //   Positioned(
        //     top: 50, // Cách mép trên 50 pixel (tránh bị dính vào thanh trạng thái pin/wifi)
        //     left: 20, // Cách mép trái 20 pixel
        //     child: IgnorePointer(
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         color: Color.fromARGB(100, 255, 255, 255),
        //         child: Text(
        //           //"Tọa độ: (${_fingers.values.elementAt(_activePointers.elementAt(0)).last.position})",
        //           //"Tọa độ: (${_fingers.entries..last.position})",
        //           "Tọa độ 1: (${currentPoints.entries.elementAt(0).value.dx.round()}, ${currentPoints.entries.elementAt(0).value.dy.round()})",
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     )
        //   ),
        
        // if (_activePointers.length == 2)
        //   Positioned(
        //     top: 50, // Cách mép trên 50 pixel (tránh bị dính vào thanh trạng thái pin/wifi)
        //     left: 20, // Cách mép trái 20 pixel
        //     child: IgnorePointer(
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         color: Color.fromARGB(100, 255, 255, 255),
        //         child: Text(
        //           "Tọa độ 1: (${currentPoints.entries.elementAt(0).value.dx.round()}, ${currentPoints.entries.elementAt(0).value.dy.round()}),\nTọa độ 2: (${currentPoints.entries.elementAt(1).value.dx.round()}, ${currentPoints.entries.elementAt(1).value.dy.round()})",
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     )
        //   ),

        // if (_activePointers.length == 3)
        //   Positioned(
        //     top: 50, // Cách mép trên 50 pixel (tránh bị dính vào thanh trạng thái pin/wifi)
        //     left: 20, // Cách mép trái 20 pixel
        //     child: IgnorePointer(
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         color: Color.fromARGB(100, 255, 255, 255),
        //         child: Text(
        //           "Tọa độ 1: (${currentPoints.entries.elementAt(0).value.dx.round()}, ${currentPoints.entries.elementAt(0).value.dy.round()})\nTọa độ 2: (${currentPoints.entries.elementAt(1).value.dx.round()}, ${currentPoints.entries.elementAt(1).value.dy.round()}),\nTọa độ 3: (${currentPoints.entries.elementAt(2).value.dx.round()}, ${currentPoints.entries.elementAt(2).value.dy.round()})",
        //           style: const TextStyle(
        //           color: Colors.white,
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     )
        //   ),
        
        // if (_activePointers.length == 4)
        //   Positioned(
        //     top: 50, // Cách mép trên 50 pixel (tránh bị dính vào thanh trạng thái pin/wifi)
        //     left: 20, // Cách mép trái 20 pixel
        //     child: IgnorePointer(
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         color: Color.fromARGB(100, 255, 255, 255),
        //         child: Text(
        //             "Tọa độ 1: (${currentPoints.entries.elementAt(0).value.dx.round()}, ${currentPoints.entries.elementAt(0).value.dy.round()})\nTọa độ 2: (${currentPoints.entries.elementAt(1).value.dx.round()}, ${currentPoints.entries.elementAt(1).value.dy.round()}),\nTọa độ 3: (${currentPoints.entries.elementAt(2).value.dx.round()}, ${currentPoints.entries.elementAt(2).value.dy.round()}),\nTọa độ 4: (${currentPoints.entries.elementAt(3).value.dx.round()}, ${currentPoints.entries.elementAt(3).value.dy.round()})",
        //             style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     )
        //   ),
      ],
    );
  }
}