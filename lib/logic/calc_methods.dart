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


List<double>? convertToVector(Map<int, Offset> points) {
  List<double> vector;
  if (points.length <= 1 || points.length >= 5) return null;
  if (points.length == 2) {
    // V = [x1, y1, x2, y2, L, angle, mx, my]
    // với hai điểm A(0,0), B(1,1)
    // [0.0000, 0.0000, 1.0000, 1.0000,        // tọa độ 2 điểm ĐÃ SẮP XẾP theo x
    // 1.4142,                                 // độ dài
    // 0.7854,                                 // góc (tính bằng rad) so với trục Ox với vector 2 điểm
    // 0.5000, 0.5000                         // trung điểm
    Offset p1 = points.values.elementAt(0);
    Offset p2 = points.values.elementAt(1);

    double x1 = p1.dx;
    double x2 = p2.dx;
    double y1 = p1.dy;
    double y2 = p2.dy;

    // List<double> sorted = [x1, x2, y1, y2];
    // sorted.sort();

    double dis = getLengthBetween2Points(p1, p2);

    //gôc giữa vector với truc Ox
    // double rad = atan2(y2 - y1, x2 - x1);         //tan = đối / kề
    // if (rad < 0) rad += pi;

    // vector (1,0)
    Offset o1 = Offset(0, 0);
    Offset o2 = Offset(1, 0);
    double rad = getAngleInRadian (p1, p2, o1, o2);
  

    Offset midpoint = Offset((x1+x2)/2, (y1+y2)/2);

    vector = List.filled(8, 0.0);
    // for (int i = 0; i<=3; i++) {
    //   vector[i] = sorted[i];
    // }

    // if (x1<x2) {
    //   vector[0] = x1;
    //   vector[1] = y1;
    //   vector[2] = x2;
    //   vector[3] = y2;
    // }
    // else {
    //   vector[0] = x2;
    //   vector[1] = y2;
    //   vector[2] = x1;
    //   vector[3] = y1;
    // }
    Map<int, Offset> points_copy = points;
    List<MapEntry<int, Offset>> sortedEntries = points_copy.entries.toList();
    sortedEntries.sort((a, b) => a.value.dx.compareTo(b.value.dx));
    Map<int, Offset> points_sorted = Map.fromEntries(sortedEntries);

    int index = 0;
    for (int i = 0; i<points_sorted.length; i++) {
      vector[index++] = points_sorted.values.elementAt(i).dx;
      vector[index++] = points_sorted.values.elementAt(i).dy;
    }

    
    vector[4] = dis;
    vector[5] = rad;
    vector[6] = midpoint.dx;
    vector[7] = midpoint.dy;

  }
  else if (points.length == 3) {

    // Tọa độ 3 điểm đã sắp xếp	x1,y1,x2,y2,x3,y3	                  6       (x1 < x2 < x3)
    // Độ dài 3 cạnh	          a, b, c	                            3
    // 3 góc (rad)	            A, B, C	                            3
    // Diện tích	              |(x2-x1)(y3-y1)-(x3-x1)(y2-y1)|/2	  1
    // Trọng tâm	              ((x1+x2+x3)/3, (y1+y2+y3)/3)	      2
    // Bán kính ngoại tiếp	    (a*b*c)/(4*diện tích)	              1
    vector = List.filled(16, 0);
    Offset p1 = points.values.elementAt(0);
    Offset p2 = points.values.elementAt(1);
    Offset p3 = points.values.elementAt(2);

    double x1 = p1.dx;
    double x2 = p2.dx;
    double x3 = p3.dx;
    double y1 = p1.dy;
    double y2 = p2.dy;
    double y3 = p3.dy;
    // List<double> sortedOffset = [x1, x2, x3, y1, y2, y3];
    // sortedOffset.sort();
    
    double dis1 = getLengthBetween2Points(p1, p2);
    double dis2 = getLengthBetween2Points(p1, p3);
    double dis3 = getLengthBetween2Points(p2, p3);

    List<double> sortedDis = [dis1, dis2, dis3];
    sortedDis.sort();

    double angle1 = getAngleInRadian(p1, p2 , p1, p3);
    double angle2 = getAngleInRadian(p2, p1 , p2, p3);
    double angle3 = getAngleInRadian(p3, p1 , p3, p2);

    List<double> sortedAgl = [angle1, angle2, angle3];
    sortedAgl.sort();

    double area = ((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1)).abs() / 2.0;

    Offset midpoint = Offset((x1+x2+x3) / 3.0, (y1+y2+y3) / 3.0);

    double circumRadius = (dis1 * dis2 * dis3) / (4*area);

    // for (int i = 0; i<=5; i++) {          //6 phần tử
    //   vector[i] = sortedOffset[i];
    // }
    Map<int, Offset> points_copy = points;
    List<MapEntry<int, Offset>> sortedEntries = points_copy.entries.toList();
    sortedEntries.sort((a, b) => a.value.dx.compareTo(b.value.dx));
    Map<int, Offset> points_sorted = Map.fromEntries(sortedEntries);

    int index = 0;
    for (int i = 0; i<points_sorted.length; i++) {
      vector[index++] = points_sorted.values.elementAt(i).dx;
      vector[index++] = points_sorted.values.elementAt(i).dy;
    }

    for (int i = 6; i<=8; i++) {          //3 phần tử
      vector[i] = sortedDis[i-6];
    }

    for (int i = 9; i<= 11; i++) {
      vector[i] = sortedAgl[i-9];
    }
    vector[12] = area;
    vector[13] = midpoint.dx;
    vector[14] = midpoint.dy;
    vector[15] = circumRadius;
  }
  else {
    
    Offset p1 = points.values.elementAt(0);
    Offset p2 = points.values.elementAt(1);
    Offset p3 = points.values.elementAt(2);
    Offset p4 = points.values.elementAt(3);

    double x1 = p1.dx;
    double x2 = p2.dx;
    double x3 = p3.dx;
    double x4 = p4.dx;
    double y1 = p1.dy;
    double y2 = p2.dy;
    double y3 = p3.dy;
    double y4 = p4.dy;

    List<double> sortedOffset = [x1, x2, x3, x4, y1, y2, y3, y4];
    sortedOffset.sort();

    double dis1 = getLengthBetween2Points(p1, p2);
    double dis2 = getLengthBetween2Points(p1, p3);
    double dis3 = getLengthBetween2Points(p1, p4);
    double dis4 = getLengthBetween2Points(p2, p3);
    double dis5 = getLengthBetween2Points(p2, p4);
    double dis6 = getLengthBetween2Points(p3, p4);

    List<double> sortedDis = [dis1, dis2, dis3, dis4, dis5, dis6];
    sortedDis.sort();

    double angle1 = getAngleInRadian(p1, p2 , p1, p3);
    double angle2 = getAngleInRadian(p1, p2 , p1, p4);
    double angle3 = getAngleInRadian(p1, p3 , p1, p4);
    double angle4 = getAngleInRadian(p2, p1 , p2, p3);
    double angle5 = getAngleInRadian(p2, p1 , p2, p4);
    double angle6 = getAngleInRadian(p2, p3 , p2, p4);
    double angle7 = getAngleInRadian(p3, p1 , p3, p2);
    double angle8 = getAngleInRadian(p3, p1 , p3, p4);
    double angle9 = getAngleInRadian(p3, p2 , p3, p4);
    double angle10 = getAngleInRadian(p4, p1 , p4, p2);
    double angle11 = getAngleInRadian(p4, p1 , p4, p3);
    double angle12 = getAngleInRadian(p4, p2 , p4, p3);

    List<double> sortedAgl = [angle1, angle2, angle3, angle4,angle5,angle6,angle7,angle8,angle9,angle10,angle11,angle12];
    sortedAgl.sort();

    Offset midpoint = Offset((x1+x2+x3+x4) / 4.0, (y1+y2+y3+y4) / 4.0);

    vector = List.filled(32, 0);

    Map<int, Offset> points_copy = points;
    List<MapEntry<int, Offset>> sortedEntries = points_copy.entries.toList();
    sortedEntries.sort((a, b) => a.value.dx.compareTo(b.value.dx));
    Map<int, Offset> points_sorted = Map.fromEntries(sortedEntries);

    int index = 0;
    for (int i = 0; i<points_sorted.length; i++) {
      vector[index++] = points_sorted.values.elementAt(i).dx;
      vector[index++] = points_sorted.values.elementAt(i).dy;
    }

    for (int i = 8; i<=13; i++) {
      vector[i] = sortedDis[i-8];
    }
    for (int i = 14; i<=25; i++) {
      vector[i] = sortedAgl[i-14];
    }
    vector[26] = midpoint.dx;
    vector[27] = midpoint.dy;
  }
  return vector;

}


