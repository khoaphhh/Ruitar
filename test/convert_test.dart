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
    expect(vector, orderedEquals([100,100,200,200, closeTo(141.42, 0.01), closeTo(0.78, 0.01), 150, 150]));
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
    expect(vector, orderedEquals([100,100,100,100,200,200,100,100,closeTo(141,1),closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/2,0.1),5000,closeTo(400/3,1), closeTo(400/3, 1),closeTo((100*100*141)/(4*5000),10)]));
  });
  test('test convertToVector 4 points', () {            //hình vuông 
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    points[1] = Offset(200, 100);
    points[2] = Offset(100, 200);
    points[3] = Offset(200, 200);
    List<double>? vector = convertToVector(points);
    expect(vector == null, false);
    expect(vector, orderedEquals([100,100,100,100,200,200,200,200,
                                  100,100,100,100,closeTo(141,1),closeTo(141,1),
                                  closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/4,0.1),closeTo(pi/2,0.1),closeTo(pi/2,0.1),closeTo(pi/2,0.1),closeTo(pi/2,0.1),
                                  150,150,
                                  0,0,0,0]));
  });
}
