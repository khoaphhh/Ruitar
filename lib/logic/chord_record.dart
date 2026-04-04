import 'package:flutter/gestures.dart';


class ChordRecord {
  final String chordName;
  final int numberOfPoints;       //số điểm chạm [2,3,4]
  late final List<Offset> vector;      //vector nhận dạng ChordRecord

  ChordRecord({required this.chordName, required this.numberOfPoints, required List<Offset> inputVector}){
    if (numberOfPoints != 2 && numberOfPoints != 3 && numberOfPoints != 4) {
      throw Exception('numberOfPoints must be 2, 3, or 4');
    }

    if (inputVector.length != numberOfPoints) throw Exception("inputVector must have the size of $numberOfPoints");
    vector = inputVector;
  }

}