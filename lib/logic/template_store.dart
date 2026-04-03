import 'package:ruitar/logic/chord_store.dart';
import 'package:ruitar/logic/chord_record.dart';
import 'package:ruitar/logic/calc_methods.dart';

import 'package:flutter/material.dart';

class TemplateStore {
  ChordStore store_2Points = ChordStore(dimension: 8);
  ChordStore store_3Points = ChordStore(dimension: 16);
  ChordStore store_4Points = ChordStore(dimension: 32);


  TemplateStore() ;
  
  void loadTemplates() {
    List<ChordRecord> cr_2points =[];
    List<ChordRecord> cr_3points =[];
    List<ChordRecord> cr_4points =[];
    

    //https://globalguitarnetwork.com/wp-content/uploads/2014/05/Open-Chords.png
    setChordBy2Offset(cr_2points, "E_minor", Offset(106, 236), Offset(168, 296));
    setChordBy2Offset(cr_2points, "E_7", Offset(106, 236), Offset(249, 161));
    setChordBy2Offset(cr_2points, "A_7", Offset(177, 240), Offset(301, 280));
    setChordBy2Offset(cr_2points, "A_minor7", Offset(177, 240), Offset(299, 152));
    setChordBy2Offset(cr_2points, "C_major7", Offset(128, 365), Offset(170, 286));

    setChordBy3Offset(cr_3points, "A_major", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "A_major7", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "A_minor", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "C_major", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "D_major", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "D_7", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "D_minor", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "D_minor7", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "E_major", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "G_major", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "G_7", Offset(100, 100), Offset(200, 200),Offset(200, 200));
    setChordBy3Offset(cr_3points, "F_major7", Offset(100, 100), Offset(200, 200),Offset(200, 200));

    setChordBy4Offset(cr_4points, "B_7", Offset(100, 100), Offset(200, 200),Offset(200, 200),Offset(200, 200));
    setChordBy4Offset(cr_4points, "C_7", Offset(100, 100), Offset(200, 200),Offset(200, 200),Offset(200, 200));
    setChordBy4Offset(cr_4points, "F_major", Offset(100, 100), Offset(200, 200),Offset(200, 200),Offset(200, 200));


    
    store_2Points.loadRecords(cr_2points);
    store_3Points.loadRecords(cr_3points);
    store_4Points.loadRecords(cr_4points);
  }
 
  

  
  
  void setChordBy2Offset(List<ChordRecord> cr_list, String name, Offset o1, Offset o2) {
    Map<int, Offset> points = {
      0 : o1,
      1 : o2,
    };
    List<double>? inputVector = convertToVector(points);
    if (inputVector != null) {
      ChordRecord cr = ChordRecord(chordName: name, numberOfPoints: 2, inputVector: inputVector);
      cr_list.add(cr);
    }
  }
  void setChordBy3Offset(List<ChordRecord> cr_list, String name, Offset o1, Offset o2, Offset o3) {
    Map<int, Offset> points = {
      0 : o1,
      1 : o2,
      2 : o3,
    };
    List<double>? inputVector = convertToVector(points);
    if (inputVector != null) {
      ChordRecord cr = ChordRecord(chordName: name, numberOfPoints: 3, inputVector: inputVector);
      cr_list.add(cr);
    }
  }
  void setChordBy4Offset(List<ChordRecord> cr_list, String name, Offset o1, Offset o2, Offset o3, Offset o4) {
    Map<int, Offset> points = {
      0 : o1,
      1 : o2,
      2 : o3,
      3 : o4,
    };
    List<double>? inputVector = convertToVector(points);
    if (inputVector != null) {
      ChordRecord cr = ChordRecord(chordName: name, numberOfPoints: 4, inputVector: inputVector);
      cr_list.add(cr);
    }
  }
}