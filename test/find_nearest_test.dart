import 'package:flutter_test/flutter_test.dart';
import 'package:ruitar/logic/chord_store.dart';
import 'package:ruitar/logic/chord_record.dart';


void main() {
  test('test loadRecords', () {
    ChordRecord c1 = ChordRecord(chordName: "chordName1", numberOfPoints: 2, inputVector: List.filled(32, 0.0));
    ChordRecord c2 = ChordRecord(chordName: "chordName2", numberOfPoints: 2, inputVector: List.filled(32, 1.0));
    ChordRecord c3 = ChordRecord(chordName: "chordName3", numberOfPoints: 2, inputVector: List.filled(32, 2.0));
    List<ChordRecord> l1 = [c1, c2, c3];
    ChordStore store = ChordStore(dimension: 32);
    store.loadRecords(l1);

    expect(store.getStore().getSize(), 3);

    // 2. Kiểm tra tính toàn vẹn của Key (Norm)
    // Giả sử bạn có hàm lấy danh sách keys theo thứ tự In-order
    List<double> keys = store.getStore().getInOrderKeys(); 
    expect(keys[0], 0.0);
    expect(keys[1], closeTo(5.656, 0.001)); // Kiểm tra xấp xỉ sqrt(32)
    expect(keys[2], closeTo(11.313, 0.001)); // Kiểm tra xấp xỉ sqrt(128)

    // 3. Kiểm tra tính đúng đắn của Dimension
    expect(store.dimension, 32);
  });
  test('Phải ném lỗi nếu chèn sai Dimension', () {
    //ChordStore store = ChordStore(dimension: 32);
    
    
    // Mong đợi hệ thống quăng ArgumentError
    expect(() => {ChordRecord(chordName: "error", numberOfPoints: 2, inputVector: List.filled(64, 0.0)) }, throwsException);
  });

  group('test hàm findNearest', () {
    
    
    
  });

}