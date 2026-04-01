import 'package:flutter_test/flutter_test.dart';
import 'package:ruitar/logic/chord_store.dart';
import 'package:ruitar/logic/chord_record.dart';


void main() {
  test('test loadRecords', () {
    ChordRecord c1 = ChordRecord(chordName: "chordName1", numberOfPoints: 2, inputVector: List.filled(8, 0.0));
    ChordRecord c2 = ChordRecord(chordName: "chordName2", numberOfPoints: 2, inputVector: List.filled(8, 1.0));
    ChordRecord c3 = ChordRecord(chordName: "chordName3", numberOfPoints: 2, inputVector: List.filled(8, 2.0));
    List<ChordRecord> l1 = [c1, c2, c3];
    ChordStore store = ChordStore(dimension: 8);
    store.loadRecords(l1);

    expect(store.getStore().getSize(), 3);

    // 2. Kiểm tra tính toàn vẹn của Key (Norm)
    // Giả sử bạn có hàm lấy danh sách keys theo thứ tự In-order
    List<double> keys = store.getStore().getInOrderKeys(); 
    expect(keys[0], 0.0);
    expect(keys[1], closeTo(2.82842712475, 0.001)); // Kiểm tra xấp xỉ sqrt(8)
    expect(keys[2], closeTo(5.65685424949, 0.001)); // Kiểm tra xấp xỉ sqrt(32)

    // 3. Kiểm tra tính đúng đắn của Dimension
    expect(store.dimension, 8);
  });
  test('Phải ném lỗi nếu chèn sai Dimension', () {    
    // Mong đợi hệ thống quăng ArgumentError
    expect(() => {ChordRecord(chordName: "error", numberOfPoints: 2, inputVector: List.filled(64, 0.0)) }, throwsException);
  });

  group('test hàm findNearest', () {
    test('test hàm findNearest', () { 
      ChordRecord c1 = ChordRecord(chordName: "chordName1", numberOfPoints: 2, inputVector: List.filled(8, 0.0));
      ChordRecord c2 = ChordRecord(chordName: "chordName2", numberOfPoints: 2, inputVector: List.filled(8, 1.0));
      ChordRecord c3 = ChordRecord(chordName: "chordName3", numberOfPoints: 2, inputVector: List.filled(8, 2.0));
      ChordRecord c4 = ChordRecord(chordName: "chordName4", numberOfPoints: 2, inputVector: List.filled(8, 3.0));
      ChordRecord c5 = ChordRecord(chordName: "chordName5", numberOfPoints: 2, inputVector: List.filled(8, 4.0));
      ChordRecord c6 = ChordRecord(chordName: "chordName6", numberOfPoints: 2, inputVector: List.filled(8, 5.0));
      List<ChordRecord> l1 = [c1, c2, c3, c4, c5, c6];
      ChordStore store = ChordStore(dimension: 8);
      store.loadRecords(l1);
      List<double> v1 = List.filled(8, 1.1);
      String? result = store.findNearest(v1)?.chordName;
      expect(result, "chordName2") ;
    });
  });
  //TODO: what about a dot within a triangle
}