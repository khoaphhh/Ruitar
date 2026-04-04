import 'chord_record.dart';
import 'package:flutter/material.dart';



class ChordStore {
  List<ChordRecord> _chordStore = [];      //sắp xếp thứ tự theo norm của chord


  ChordStore();

  void loadRecords(List<ChordRecord> records) {
    for (ChordRecord record in records) {
      _chordStore.add(record);      // Cây tự động xếp theo Norm
    }
  }

  ChordRecord? findNearest(List<Offset> inputVector) {      //bảo đảm inputVector cùng số dimesion
    //sau khi lọc trong khoảng norm rồi thì tính khoảng cách
    ChordRecord? bestMatch;
    double minDistance = double.infinity;

    for (ChordRecord candidate in _chordStore) {
      double dist = similarityScore(inputVector, candidate.vector);
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

  double similarityScore(List<Offset> v1, List<Offset> v2) {
    if (v1.length != v2.length) return double.infinity;


    // 2. Tính Trọng tâm
    Offset centerV1 = getMidPoint(v1);
    Offset centerV2 = getMidPoint(v2);

    // Độ lệch Vị trí bấm (Nếu bạn cần)
    double dPosition = (centerV2 - centerV1).distance;

    // 3. Dịch chuyển toàn bộ tập điểm về quanh gốc (0,0)
    List<Offset> normV1 = v1.map((Offset p) {
      return p - centerV1;
    }).toList();
    List<Offset> normV2 = v2.map((Offset p) {
      return p - centerV1;
    }).toList();

    // 4. Tìm cách ghép cặp có tổng độ lệch nhỏ nhất (Thử mọi Hoán vị)
    double dShape = bestMatchPossible(normV1, normV2);

    // --- BẢNG TRỌNG SỐ ---
    double wPosition = 1.0; // Phạt nếu bấm sai vị trí ngăn đàn
    double wShape = 1.0;    // Phạt nếu sai thế tay (sai tỷ lệ, sai khoảng cách ngón)

    return (dPosition * wPosition) + (dShape * wShape);
  }

  Offset getMidPoint(List<Offset> points) {
    double sumX = 0, sumY = 0;
    int size = points.length;
    for (int i = 0; i<size; i++) {
      sumX += points.elementAt(i).dx;
      sumY += points.elementAt(i).dy;
    }
    return Offset(sumX / size, sumY / size);
  }

  //sinh ra mọi hoán vị bằng hàm getPermutations và tìm khoảng cách nhỏ nhất với mỗi trường hợp
  double bestMatchPossible(List<Offset> v1, List<Offset> v2) {
    List<List<Offset>> allPermutations = getPermutations(v2);
    double minDistance = double.infinity;

    for (List<Offset> perm in allPermutations) {
      double currentDistance = 0;
      for (int i = 0; i < v1.length; i++) {
        currentDistance += (v1[i] - perm[i]).distance; // Khoảng cách Euclid P-to-P
      }
      if (currentDistance < minDistance) {
        minDistance = currentDistance;
      }
    }
    return minDistance;
  }
  //thuật toán sinh tất cả các hoán vị
  List<List<Offset>> getPermutations(List<Offset> list) {
    if (list.length <= 1) return [list];
    List<List<Offset>> result = [];
    for (int i = 0; i < list.length; i++) {
      Offset current = list[i];
      List<Offset> remaining = List<Offset>.from(list);
      remaining.removeAt(i);
      for (var perm in getPermutations(remaining)) {
        result.add([current, ...perm]);
      }
    }
    return result;
  }

  //getter
  List<ChordRecord> getStore () {
    return _chordStore;
  }

  
}