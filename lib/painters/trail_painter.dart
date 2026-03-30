import 'package:flutter/material.dart';
import '../models/trail_point.dart';

class TrailPainter extends CustomPainter {
  final Map<int, List<TrailPoint>> fingers;
  final Set<int> activePointers;
  final int timeToLive;
  final double MAX_CURSOR_SIZE = 30;  //set độ lớn cursor

  TrailPainter({
    required this.fingers,
    required this.activePointers,
    required Listenable repaint,
    this.timeToLive = 300,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    
    // dọn dẹp RAM (?)
    for (var entry in fingers.entries) {
      var trail = entry.value;
      trail.removeWhere((p) => currentTime - p.creationTime > timeToLive);
    }

    // khởi tạo cọ vẽ
    final paint = Paint()..style = PaintingStyle.fill;

    for (var entry in fingers.entries) {
      int pointerId = entry.key;
      var trail = entry.value;
      bool isCurrentlyPressed = activePointers.contains(pointerId);

      for (int i = 0; i < trail.length; i++) {
        var point = trail[i];
        bool isHead = isCurrentlyPressed && (i == trail.length - 1);
        double lifeLeft;

        if (isHead) {
          lifeLeft = 1.0; 
          point.creationTime = currentTime; 
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
            //stops: const [0.0, 0.5, 1.0], 
          );

          paint.shader = headGradient.createShader(
            Rect.fromCircle(center: point.position, radius: MAX_CURSOR_SIZE), //Kích thước của điểm chạm (không phải đuôi) là max
          );

          canvas.drawCircle(point.position, MAX_CURSOR_SIZE, paint);
          continue;
        } else {   //đuôi

          double ageRatio = (currentTime - point.creationTime) / timeToLive;
          lifeLeft = 1.0 - ageRatio.clamp(0.0, 1.0); 

          if (lifeLeft <= 0) continue; 

          // double currentRadius = 0.8 * MAX_CURSOR_SIZE * lifeLeft; 

          // // final Gradient trailGradient = RadialGradient(
          // //   colors: [
          // //     const Color.fromARGB(255,251,251,251),
          // //     const Color.fromARGB(255, 0, 58, 107),
          // //   ],
          // // );

          // // paint.shader = trailGradient.createShader(
          // //   Rect.fromCircle(center: point.position, radius: currentRadius),
          // // );
          // int transparency = (100 * lifeLeft).truncate();
          paint.color = Color.fromARGB(150,251,251,251);
          canvas.drawCircle(point.position, 3, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant TrailPainter oldDelegate) {
    return true; // ticker luôn đập nhịp
  }
}