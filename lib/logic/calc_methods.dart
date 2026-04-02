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
  //số chiều L = 2
  //số loại tỷ lệ scale S = 3; tương ứng với s=0,1,2. tại mỗi tỉ lệ cho 1 bước sóng để bắt các thay đổi (nhỏ, trung, lớn)
  //với mỗi tỷ lệ tính 2 hàm sine.cosin => tổng cộng 2*3*2 = 12 chiều
  List<double> vector = List.filled(12, 0);
  List<double> lamda = [10,100,1000];
  if (points.length <= 1 || points.length >= 5) return null;
  if (points.length == 2) {
    Offset p1 = points.values.elementAt(0);
    Offset p2 = points.values.elementAt(1);
    double x1 = p1.dx;
    double x2 = p2.dx;
    double y1 = p1.dy;
    double y2 = p2.dy;

    List<double> vector1 = List.filled(12, 0);
    List<double> vector2 = List.filled(12, 0);

    int index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x1/lamda[i]) ;
      vector1[index++] = cosin;
      double sine = sin(x1/lamda[i]) ;
      vector1[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y1/lamda[i]) ;
      vector1[index++] = cosin;
      double sine = sin(y1/lamda[i]) ;
      vector1[index++] = sine;
    }

    index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x2/lamda[i]) ;
      vector2[index++] = cosin;
      double sine = sin(x2/lamda[i]) ;
      vector2[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y2/lamda[i]) ;
      vector2[index++] = cosin;
      double sine = sin(y2/lamda[i]) ;
      vector2[index++] = sine;
    }
    for (int i=0; i<12; i++) {
      vector[i] = max(vector1[i], vector2[i]);
    }
  }
  else if (points.length == 3) {
    Offset p1 = points.values.elementAt(0);
    Offset p2 = points.values.elementAt(1);
    Offset p3 = points.values.elementAt(2);

    double x1 = p1.dx;
    double x2 = p2.dx;
    double x3 = p3.dx;
    double y1 = p1.dy;
    double y2 = p2.dy;
    double y3 = p3.dy;

    List<double> vector1 = List.filled(12, 0);
    List<double> vector2 = List.filled(12, 0);
    List<double> vector3 = List.filled(12, 0);  

    int index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x1/lamda[i]) ;
      vector1[index++] = cosin;
      double sine = sin(x1/lamda[i]) ;
      vector1[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y1/lamda[i]) ;
      vector1[index++] = cosin;
      double sine = sin(y1/lamda[i]) ;
      vector1[index++] = sine;
    }

    index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x2/lamda[i]) ;
      vector2[index++] = cosin;
      double sine = sin(x2/lamda[i]) ;
      vector2[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y2/lamda[i]) ;
      vector2[index++] = cosin;
      double sine = sin(y2/lamda[i]) ;
      vector2[index++] = sine;
    }

    index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x3/lamda[i]) ;
      vector3[index++] = cosin;
      double sine = sin(x3/lamda[i]) ;
      vector3[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y3/lamda[i]) ;
      vector3[index++] = cosin;
      double sine = sin(y3/lamda[i]) ;
      vector3[index++] = sine;
    }
    for (int i=0; i<12; i++) {
      vector[i] = max(vector1[i], max(vector2[i],vector3[i]));
    }
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

    List<double> vector1 = List.filled(12, 0);
    List<double> vector2 = List.filled(12, 0);
    List<double> vector3 = List.filled(12, 0);  
    List<double> vector4 = List.filled(12, 0);  

    int index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x1/lamda[i]) ;
      vector1[index++] = cosin;
      double sine = sin(x1/lamda[i]) ;
      vector1[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y1/lamda[i]) ;
      vector1[index++] = cosin;
      double sine = sin(y1/lamda[i]) ;
      vector1[index++] = sine;
    }

    index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x2/lamda[i]) ;
      vector2[index++] = cosin;
      double sine = sin(x2/lamda[i]) ;
      vector2[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y2/lamda[i]) ;
      vector2[index++] = cosin;
      double sine = sin(y2/lamda[i]) ;
      vector2[index++] = sine;
    }

    index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x3/lamda[i]) ;
      vector3[index++] = cosin;
      double sine = sin(x3/lamda[i]) ;
      vector3[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y3/lamda[i]) ;
      vector3[index++] = cosin;
      double sine = sin(y3/lamda[i]) ;
      vector3[index++] = sine;
    }

    index = 0;
    for (int i =0; i<=2; i++) {
      double cosin = cos(x4/lamda[i]) ;
      vector4[index++] = cosin;
      double sine = sin(x4/lamda[i]) ;
      vector4[index++] = sine;
    }
    for (int i =0; i<=2; i++) {
      double cosin = cos(y4/lamda[i]) ;
      vector4[index++] = cosin;
      double sine = sin(y4/lamda[i]) ;
      vector4[index++] = sine;
    }

    for (int i=0; i<12; i++) {
      vector[i] = max(vector1[i], max(vector2[i], max(vector3[i],vector4[i])));
    }

  }
  return vector;

}


