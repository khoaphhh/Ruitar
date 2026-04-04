import 'dart:math';
import 'package:flutter/material.dart';

double getLengthBetween2Points(Offset o1, Offset o2) {
  double dx = (o1.dx - o2.dx).abs();
  double dy = (o1.dy - o2.dy).abs();
  return sqrt(pow(dx,2) + pow(dy,2));
}

double getAngleInRadian (Offset a, Offset b, Offset c, Offset d) {          // giữa đoạn thẳng AB và CD
  //góc giữa AB và trục Ox
  double rad1 = atan2(b.dy - a.dy, b.dx - a.dx);
  if (rad1 < 0) rad1 += pi;
  //góc giữa CD và trục Ox
  double rad2 = atan2(d.dy - c.dy, d.dx - c.dx);
  if (rad2 < 0) rad2 += pi;
  double result = (rad1 - rad2).abs();
  if (result > pi/2) result -= pi/2;
  return result;
}


List<Offset>? convertToVector(Map<int, Offset> points) {
  List<Offset> vector = [];
  if (points.length <= 1 || points.length >= 5) return null;
  for (int i = 0; i<points.length; i++) {
    vector.add(points.values.elementAt(i));
  }
  return vector;
}


