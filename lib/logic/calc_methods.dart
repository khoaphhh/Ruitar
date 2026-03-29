import 'dart:math';
import 'package:flutter/material.dart';

double getLengthBetween2Points(Offset o1, Offset o2) {
  double dx = (o1.dx - o2.dx).abs();
  double dy = (o1.dy - o2.dy).abs();
  return sqrt(pow(dx,2) + pow(dy,2));
}

List<double> convertToVector(List<Offset> points) {
    List<double> distances = [];
    //khoảng cách của tất cả các cặp điểm
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        distances.add(getLengthBetween2Points(points[i], points[j]));
      }
    }

    distances.sort();

    //chuẩn hóa
    double furthest = distances.last;
    for (double d in distances) {
      d = d / furthest;
    }
    return distances;
}

