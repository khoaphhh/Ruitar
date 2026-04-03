// import 'dart:ffi';

// import 'package:ruitar/logic/avl_node.dart';

import 'chord_record.dart';
import 'avl_tree.dart';
import 'dart:math';



class ChordStore {
  final AVLTree<double, ChordRecord> _chordStore = AVLTree();      //sắp xếp thứ tự theo norm của chord
  final int dimension;
  double epsilon = 30.0;                                        //px, Lọc norm trước rồi mới so sánh

  ChordStore({required this.dimension});

  void loadRecords(List<ChordRecord> records) {
    for (ChordRecord record in records) {
      if (record.vector.length != dimension) throw Exception('record\'s dimesion doesn\'t equal to store\'s dimension');
      double norm = record.norm; // Tính Norm nhiều chiều
      _chordStore.insert(norm, record);       // Cây tự động xếp theo Norm
    }
  }

  ChordRecord? findNearest(List<double> inputVector) {      //bảo đảm inputVector cùng số dimesion
    if (inputVector.length != dimension) throw Exception('inputVector must have &dimension dimension');


    //thứ cách 1 : lọc các norm gần nhau
    // //tính norm inputVector
    // double sum = 0.0;
    // for (int i = 0; i<inputVector.length; i++) {
    //   sum += inputVector.elementAt(i) * inputVector.elementAt(i);
    // }
    // double inputNorm = sqrt(sum);

    // List<ChordRecord> candidates = [];
    // _chordStore.findInRange(candidates, _chordStore.getRoot(), inputNorm, epsilon);

    // if (candidates.isEmpty) return null;

    //thứ cách 2 : không lọc mà lấy tất cả
    List<ChordRecord> candidates = _chordStore.getInOrderValues();

    //sau khi lọc trong khoảng norm rồi thì tính khoảng cách
    ChordRecord? bestMatch;
    double minDistance = double.infinity;

    for (ChordRecord candidate in candidates) {
      double dist = similarityScore(inputVector, candidate);
      if (dist < minDistance) {
        minDistance = dist;
        bestMatch = candidate;
      }
    }
    return bestMatch;
  }


  // double distanceToRecord(List<double> inputVector, ChordRecord record) {
  //   double dis = 0;
  //   for (int i = 0; i < dimension; i++) {
  //     dis += (inputVector.elementAt(i) - record.vector.elementAt(i))*(inputVector.elementAt(i) - record.vector.elementAt(i));
  //   }
  //   return sqrt(dis);
  // }

  double similarityScore(List<double> inputVector, ChordRecord record) {
    double score = 0;
    List<double> v1 = inputVector;
    List<double> v2 = record.vector;

    if (inputVector.length == 8) {
      // V = [x1, y1, x2, y2, L, angle, mx, my]

      double distance1 = sqrt(pow(v1[0] - v2[0], 2) + pow(v1[1] - v2[1], 2));       //khoảng cách từ đầu này đến đầu kia
      double distance2 = sqrt(pow(v1[2] - v2[2], 2) + pow(v1[3] - v2[3], 2));       //khoảng cách từ đích này đến đích kia
      double distance  = (distance1 + distance2) / 2;

      double length_diff = (v1[4] - v2[4]).abs();

      double angle_diff = (v1[5] - v2[5]).abs();

      double midpoint_diff = sqrt(pow(v1[6] - v2[6], 2) + pow(v1[7] - v2[7], 2));

      double weight_distance = 1.0;  // weight các yếu tố
      double weight_length_diff = 1.0; 
      double weight_angle_diff = 100.0;      //angle có giá trị nhỏ =>scale lên
      double weight_midpoint_diff = 1.0;

  
      score = (weight_distance * distance) + (weight_length_diff * length_diff) + (weight_angle_diff * angle_diff) + (weight_midpoint_diff * midpoint_diff);

    }
    else if (inputVector.length == 16) {

    }
    else if (inputVector.length == 32) {

    }
    return score;
  }

  //getter
  AVLTree<double, ChordRecord> getStore () {
    return _chordStore;
  }

  
}