import 'package:flutter_test/flutter_test.dart';
import 'package:ruitar/logic/chord_store.dart';
import 'package:ruitar/logic/chord_record.dart';


void main() {
  test('test loadRecords', () {
    ChordRecord c1 = ChordRecord(chordName: "chordName1", numberOfPoints: 2, inputVector: List.filled(2, Offset(0,0)));
    ChordRecord c2 = ChordRecord(chordName: "chordName2", numberOfPoints: 2, inputVector: List.filled(2, Offset(1,1)));
    ChordRecord c3 = ChordRecord(chordName: "chordName3", numberOfPoints: 3, inputVector: List.filled(3, Offset(0,0)));
    expect(() => {ChordRecord(chordName: "error", numberOfPoints: 2, inputVector: List.filled(64, Offset(0,0))) }, throwsException);
    List<ChordRecord> l1 = [c1, c2, c3];
    ChordStore store = ChordStore();
    store.loadRecords(l1);

    expect(store.getStore().length, 3);


    // 3. Kiểm tra tính đúng đắn của Dimension
    expect(store.getStore().elementAt(0), c1);
    expect(store.getStore().elementAt(1), c2);
    expect(store.getStore().elementAt(2), c3);



  });


  group('test hàm findNearest', () {
    test('test hàm findNearest', () { 
      ChordRecord c1 = ChordRecord(chordName: "chordName1", numberOfPoints: 2, inputVector: List.filled(2, Offset(0.0, 100)));
      ChordRecord c2 = ChordRecord(chordName: "chordName2", numberOfPoints: 2, inputVector: List.filled(2, Offset(1.0, 100)));
      ChordRecord c3 = ChordRecord(chordName: "chordName3", numberOfPoints: 2, inputVector: List.filled(2, Offset(2.0, 100)));
      ChordRecord c4 = ChordRecord(chordName: "chordName4", numberOfPoints: 2, inputVector: List.filled(2, Offset(3.0, 100)));
      ChordRecord c5 = ChordRecord(chordName: "chordName5", numberOfPoints: 2, inputVector: List.filled(2, Offset(4.0, 100)));
      ChordRecord c6 = ChordRecord(chordName: "chordName6", numberOfPoints: 3, inputVector: List.filled(3, Offset(2.6, 100)));
      List<ChordRecord> l1 = [c1, c2, c3, c4, c5, c6];
      ChordStore store = ChordStore();
      store.loadRecords(l1);
      List<Offset> v1 = List.filled(2, Offset(2.6, 100));
      String? result = store.findNearest(v1)?.chordName;
      expect(result, "chordName4") ;
    });
  });
  //TODO: what about a dot within a triangle
}