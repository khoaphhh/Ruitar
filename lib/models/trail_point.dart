import 'package:flutter/material.dart';

class TrailPoint {
  final Offset position;
  int creationTime; //thời gian để tính toán độ nhỏ dần

  TrailPoint(this.position, this.creationTime);
}