import 'dart:math';


class ChordRecord {
  final String chordName;
  final int numberOfPoints;       //số điểm chạm [2,3,4]
  late final List<double> vector;      //vector nhận dạng ChordRecord
  late final double norm;

  ChordRecord({required this.chordName, required this.numberOfPoints, required inputVector}){
    if (numberOfPoints != 2 && numberOfPoints != 3 && numberOfPoints != 4) {
      throw Exception('numberOfPoints must be 2, 3, or 4');
    }
    final size = _calcVectorSize(numberOfPoints);

    if (inputVector.length != size) throw Exception("inputVector must have the size of %size");
    vector = inputVector;

    //tính norm
    double sum = 0.0;
    for (int i = 0; i<size; i++) {
      sum += vector.elementAt(i) * vector.elementAt(i);
    }
    norm = sqrt(sum);
  }

  int _calcVectorSize(int n) {
    if (n == 2) return 8;
    if (n == 3) return 16;
    if (n == 4) return 32;
    throw Exception('numberOfPoints must be 2, 3, or 4');
  }

}