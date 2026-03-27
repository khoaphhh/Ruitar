import 'package:flutter/material.dart';
import '../models/trail_point.dart';
import '../painters/trail_painter.dart';

typedef TouchCallback = void Function(Map<int, Offset> points);

class TouchDetector extends StatefulWidget {
  final TouchCallback onUpdate;

  const TouchDetector({super.key, required this.onUpdate});

  @override
  State<TouchDetector> createState() {
    return _TouchDetectorState();    
  }
}

class _TouchDetectorState extends State<TouchDetector> with SingleTickerProviderStateMixin {
  final Map<int, List<TrailPoint>> _fingers = {};
  late AnimationController _ticker;               // Khi khởi tạo _ticker và gọi hàm .repeat(), Mỗi lần gõ nhịp, sẽ gọi CustomPainter vẽ lại đuôi
  final Set<int> _activePointers = {};

  @override
  void initState() {
    super.initState();
    // Ticker chạy liên tục làm nhịp đập cho CustomPainter
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _handlePointerDown(PointerEvent event) {
    _activePointers.add(event.pointer); // Đánh dấu ngón này đang giữ
    _fingers.putIfAbsent(event.pointer, () => []);
    _fingers[event.pointer]!.add(TrailPoint(event.localPosition, DateTime.now().millisecondsSinceEpoch));
    _triggerUpdate();
  }

  void _handlePointerMove(PointerEvent event) {
    if (_activePointers.contains(event.pointer)) {
      _fingers[event.pointer]!.add(TrailPoint(event.localPosition, DateTime.now().millisecondsSinceEpoch));
      _triggerUpdate();
    }
  }

  void _handlePointerUp(PointerEvent event) {
    _activePointers.remove(event.pointer); // chỉ bỏ đánh dấu đang giữ, KHÔNG xóa khỏi _fingers
    _triggerUpdate();
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
    return Listener(
      //Bắt buộc phải có
      behavior: HitTestBehavior.opaque,
      
      //Khi nhấn 1 ngón
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove,
      onPointerUp: _handlePointerUp,
      onPointerCancel: _handlePointerUp,

      child: Container(
        color: Color.fromARGB(255,228,244,252),
        child: CustomPaint(
          painter: TrailPainter(
            fingers: _fingers,
            activePointers: _activePointers,
            repaint: _ticker, // Ticker ép Painter vẽ lại liên tục 60fps
            timeToLive: 200,  // tốc độ shrink của đuôi
          ),
          size: Size.infinite,
        ),
      )
      
    );
  }
}