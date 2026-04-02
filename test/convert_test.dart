import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:ruitar/logic/calc_methods.dart';

void main() {
  test('test convertToVector 2 points', () {
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    points[1] = Offset(200, 200);
    List<double>? vector = convertToVector(points);
    expect(vector == null, false);
    expect(vector, orderedEquals([closeTo(0.408,0.01),closeTo(0.912,0.01),closeTo(0.540,0.01),closeTo(0.909,0.01),closeTo(0.995,0.01),closeTo(0.199,0.01),closeTo(0.408,0.01),closeTo(0.913,0.01),closeTo(0.540,0.01),closeTo(0.909,0.01),closeTo(0.995,0.01),closeTo(0.199,0.01)]));
  });
  test('null convertToVector', () {
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    List<double>? vector = convertToVector(points);
    expect(vector == null, true);
  });
  test('test convertToVector 3 points', () {        //hình tam giác vuông
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    points[1] = Offset(200, 100);
    points[2] = Offset(100, 200);
    List<double>? vector = convertToVector(points);
    expect(vector == null, false);
    expect(vector, orderedEquals([closeTo(0.408,0.01),closeTo(0.912,0.01),closeTo(0.540,0.01),closeTo(0.909,0.01),closeTo(0.995,0.01),closeTo(0.199,0.01),closeTo(0.408,0.01),closeTo(0.913,0.01),closeTo(0.540,0.01),closeTo(0.909,0.01),closeTo(0.995,0.01),closeTo(0.199,0.01)]));
  });
  test('test convertToVector 4 points', () {            //hình vuông 
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    points[1] = Offset(200, 100);
    points[2] = Offset(100, 200);
    points[3] = Offset(200, 200);
    List<double>? vector = convertToVector(points);
    expect(vector == null, false);
    expect(vector, orderedEquals([closeTo(0.408,0.01),closeTo(0.912,0.01),closeTo(0.540,0.01),closeTo(0.909,0.01),closeTo(0.995,0.01),closeTo(0.199,0.01),closeTo(0.408,0.01),closeTo(0.913,0.01),closeTo(0.540,0.01),closeTo(0.909,0.01),closeTo(0.995,0.01),closeTo(0.199,0.01)]));

  });

  //TODO: 3 trường hợp đều cho 1 kết quả (cần tính lại logic gộp)
}
