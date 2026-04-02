import 'dart:math';


class ChordRecord {
  final String chordName;
  late final List<double> vector;      //vector nhận dạng ChordRecord
  late final double norm;

  ChordRecord({required this.chordName, required inputVector}){
    if (inputVector.length != 12) throw Exception("inputVector lenght must be 12");
    vector = inputVector;
    //tính norm
    double sum = 0.0;
    for (int i = 0; i<12; i++) {
      sum += vector.elementAt(i) * vector.elementAt(i);
    }
    norm = sqrt(sum);
  }

  // int _calcVectorSize(int n) {
  //   if (n == 2) return 8;
  //   if (n == 3) return 16;
  //   if (n == 4) return 32;
  //   throw Exception('numberOfPoints must be 2, 3, or 4');
  // }

}