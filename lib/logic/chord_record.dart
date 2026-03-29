import 'dart:math';

class ChordRecord {
  final String chordName;
  final List<double> vector;      //vector lưu các khoảng cách giữa 2 điểm bất kì
  late final double norm;         //norm chuẩn euclid, giá trị norm = độ dài cảu vector

  ChordRecord({required this.chordName, required this.vector}) {
    //tính norm
    double sumOfSquared = 0;
    for (int i = 0; i<vector.length; i++) {
      sumOfSquared += pow(vector.elementAt(i),2);
    }
    norm = sqrt(sumOfSquared);    
  }
}