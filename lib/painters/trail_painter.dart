import 'package:flutter/material.dart';
import '../models/trail_point.dart';

class TrailPainter extends CustomPainter {
  final Map<int, List<TrailPoint>> fingers;
  final Set<int> activePointers;
  final int timeToLive;
  final double MAX_CURSOR_SIZE = 40;  //set độ lớn cursor

  TrailPainter({
    required this.fingers,
    required this.activePointers,
    required Listenable repaint,
    this.timeToLive = 300,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    
    // khởi tạo cọ vẽ
    final paint = Paint();
    paint.style = PaintingStyle.fill;

    for (MapEntry<int, List<TrailPoint>> entry in fingers.entries) {
      int pointerId = entry.key;              //entry: Map<int, List<TrailPoint>>
      List<TrailPoint> trail = entry.value;
      bool isCurrentlyPressed = activePointers.contains(pointerId);

      if (isCurrentlyPressed && trail.isNotEmpty) {
        //xóa các điểm trên trail khi quá thời gian (trừ điểm đầu)
        trail.removeWhere((p) => (currentTime - p.creationTime > timeToLive && p != trail.last));
      } else {
        //nhấc tay lên: xóa hết các điểm trên trail
        trail.removeWhere((p) => currentTime - p.creationTime > timeToLive);
      }

      // for (int i = 0; i < trail.length; i++) {
      //   TrailPoint point = trail[i];
      //   bool isHead = isCurrentlyPressed && (i == trail.length - 1);
      //   double lifeLeft;

      //   if (isHead) {
      //     lifeLeft = 1.0; 
      //     point.creationTime = currentTime; 
      //     final Gradient headGradient = RadialGradient(
      //       colors: [
      //         // const Color.fromARGB(255,251,251,251),
      //         // const Color.fromARGB(255,255,163,34),
      //         // const Color.fromARGB(255,187,20,20),
      //         // const Color.fromARGB(255, 0, 58, 107),
      //         const Color.fromARGB(255,251,251,251),
      //         const Color.fromARGB(150,251,251,251),
      //         const Color.fromARGB(0,251,251,251),
      //       ],
      //       //stops: const [0.0, 0.0, 2.0], 
      //     );

      //     paint.shader = headGradient.createShader(
      //       Rect.fromCircle(center: point.position, radius: MAX_CURSOR_SIZE), //Kích thước của điểm chạm (không phải đuôi) là max
      //     );

      //     canvas.drawCircle(point.position, MAX_CURSOR_SIZE, paint);
      //     continue;
      //   } else {   //đuôi

      //     double ageRatio = (currentTime - point.creationTime) / timeToLive;
      //     lifeLeft = 1.0 - ageRatio.clamp(0.0, 1.0); 

      //     if (lifeLeft <= 0) continue; 

      //     // double currentRadius = 0.8 * MAX_CURSOR_SIZE * lifeLeft; 

      //     // // final Gradient trailGradient = RadialGradient(
      //     // //   colors: [
      //     // //     const Color.fromARGB(255,251,251,251),
      //     // //     const Color.fromARGB(255, 0, 58, 107),
      //     // //   ],
      //     // // );

      //     // // paint.shader = trailGradient.createShader(
      //     // //   Rect.fromCircle(center: point.position, radius: currentRadius),
      //     // // );
      //     // int transparency = (100 * lifeLeft).truncate();
      //     paint.color = Color.fromARGB(150,251,251,251);
      //     canvas.drawCircle(point.position, 3, paint);
      //   }
      // }
      Path trailPath = Path();
      if (trail.isNotEmpty) {
        //bắt đầu từ điểm trail[0] và nối tới đầu
        trailPath.moveTo(trail[0].position.dx, trail[0].position.dy);
        for (int i = 1; i < trail.length; i++) {
          trailPath.lineTo(trail[i].position.dx, trail[i].position.dy);
        }
      }

      Paint pathPaint = Paint()
      ..color = Color.fromARGB(150, 251, 251, 251)// Opacity áp dụng đều cho cả đường
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeJoin = StrokeJoin.round // Bo tròn các góc cua
      ..strokeCap = StrokeCap.round;
      canvas.drawPath(trailPath, pathPaint);

      
      // for (int i = 0; i < trail.length - 1; i++) {
      //   // TrailPoint point1 = trail[i];
      //   // TrailPoint point2 = trail[i + 1];
        
      //   // Paint dynamicPaint = Paint()
      //   // ..color = Color.fromARGB(150,251,251,251)
      //   // ..style = PaintingStyle.fill
      //   // ..strokeCap = StrokeCap.butt
      //   // ..strokeWidth = 20.0;

      //   // paint.color = Color.fromARGB(150,251,251,251);
      //   // paint.strokeWidth = 20;

      //   Paint pathPaint = Paint()
      //   ..color = Color.fromARGB(100, 251, 251, 251)// Opacity áp dụng đều cho cả đường
      //   ..style = PaintingStyle.stroke
      //   ..strokeWidth = 4.0
      //   ..strokeJoin = StrokeJoin.round // Bo tròn các góc cua
      //   ..strokeCap = StrokeCap.round;
      //   canvas.drawPath(trailPath, pathPaint);

      //   //canvas.drawLine(point1.position, point2.position, dynamicPaint);
      // }
      if (isCurrentlyPressed && trail.isNotEmpty) {
        TrailPoint headPoint = trail.last;
        
        final Gradient headGradient = RadialGradient(
          colors: [
            // const Color.fromARGB(255,251,251,251),
            // const Color.fromARGB(255,255,163,34),
            // const Color.fromARGB(255,187,20,20),
            // const Color.fromARGB(255, 0, 58, 107),
            const Color.fromARGB(255,251,251,251),
            const Color.fromARGB(150,251,251,251),
            const Color.fromARGB(0,251,251,251),
          ],
          //stops: const [0.0, 0.0, 2.0], 
        );
        paint.shader = headGradient.createShader(
          Rect.fromCircle(center: headPoint.position, radius: MAX_CURSOR_SIZE), //Kích thước của điểm chạm (không phải đuôi) là max
        );

        canvas.drawCircle(headPoint.position, MAX_CURSOR_SIZE, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant TrailPainter oldDelegate) {
    return true; // ticker luôn đập nhịp
  }
}