import 'chord_record.dart';



class ChordStore {
  final List<ChordRecord> _chordStore = [];      //sắp xếp thứ tự theo norm của chord
  void addChordRecord (ChordRecord cr) {
    if (_chordStore.isEmpty) {
      _chordStore.add(cr);   
      return;             
    }
    
    _chordStore.add(cr);//TODO: làm sao O(logN)
  }
}