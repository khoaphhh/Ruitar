import 'package:flutter_test/flutter_test.dart';
import 'package:ruitar/logic/calc_methods.dart';

void main() {
  test('test convertToVector 2 points', () {
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    points[1] = Offset(200, 200);
    List<Offset>? vector = convertToVector(points);
    expect(vector == null, false);
    expect(vector, [Offset(100, 100), Offset(200, 200)]);
  });
  test('null convertToVector', () {
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    List<Offset>? vector = convertToVector(points);
    expect(vector == null, true);
  });
  test('test convertToVector 3 points', () {        //hình tam giác vuông
    Map<int,Offset> points = {};
    points[0] = Offset(100, 100);
    points[1] = Offset(200, 100);
    points[2] = Offset(100, 200);
    List<Offset>? vector = convertToVector(points);
    expect(vector == null, false);
    expect(vector, [Offset(100, 100), Offset(200, 100), Offset(100,200)]);
  });

}
