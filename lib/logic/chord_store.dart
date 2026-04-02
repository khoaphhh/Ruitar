// import 'dart:ffi';

// import 'package:ruitar/logic/avl_node.dart';

import 'chord_record.dart';
import 'avl_tree.dart';
import 'dart:math';



class ChordStore {
  final AVLTree<double, ChordRecord> _chordStore = AVLTree();      //sắp xếp thứ tự theo norm của chord
  double epsilon = 15.0;                                        //px, Lọc norm trước rồi mới so sánh

  //ChordStore();

  void loadRecords(List<ChordRecord> records) {
    for (ChordRecord record in records) {
      double norm = record.norm; // Tính Norm nhiều chiều
      _chordStore.insert(norm, record);       // Cây tự động xếp theo Norm
    }
  }

  ChordRecord? findNearest(List<double> inputVector) {      //bảo đảm inputVector cùng số dimesion

    //tính norm inputVector
    double sum = 0.0;
    for (int i = 0; i<12; i++) {
      sum += inputVector.elementAt(i) * inputVector.elementAt(i);
    }
    double inputNorm = sqrt(sum);

    List<ChordRecord> candidates = [];
    _chordStore.findInRange(candidates, _chordStore.getRoot(), inputNorm, epsilon);

    if (candidates.isEmpty) return null;

    //sau khi lọc trong khoảng norm rồi thì tính khoảng cách
    ChordRecord? bestMatch;
    double minDistance = double.infinity;

    for (ChordRecord candidate in candidates) {
      double dist = distanceToRecord(inputVector, candidate);
      if (dist < minDistance) {
        minDistance = dist;
        bestMatch = candidate;
      }
    }
    return bestMatch;
  }


  double distanceToRecord(List<double> inputVector, ChordRecord record) {
    double dis = 0;
    for (int i = 0; i < 12; i++) {
      dis += (inputVector.elementAt(i) - record.vector.elementAt(i)) * (inputVector.elementAt(i) - record.vector.elementAt(i));
    }
    return sqrt(dis);
  }
  //getter
  AVLTree<double, ChordRecord> getStore () {
    return _chordStore;
  }
}