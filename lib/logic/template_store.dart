import 'package:ruitar/logic/chord_store.dart';
import 'package:ruitar/logic/chord_record.dart';
import 'package:ruitar/logic/calc_methods.dart';

import 'package:flutter/material.dart';

class TemplateStore {
  ChordStore store = ChordStore();

  TemplateStore() ;
  
  void loadTemplates() {
    List<ChordRecord> chordRecords =[];
    


    chordRecords.add(ChordRecord(chordName: "E_minor", numberOfPoints: 2, inputVector: [Offset(106, 236), Offset(168, 296)]));
    chordRecords.add(ChordRecord(chordName: "E_7", numberOfPoints: 2, inputVector: [Offset(106, 236), Offset(249, 161)]));
    chordRecords.add(ChordRecord(chordName: "A_7", numberOfPoints: 2, inputVector: [Offset(177, 240), Offset(301, 280)]));
    chordRecords.add(ChordRecord(chordName: "A_minor7", numberOfPoints: 2, inputVector: [Offset(177, 240), Offset(299, 152)]));
    chordRecords.add(ChordRecord(chordName: "C_major7", numberOfPoints: 2, inputVector: [Offset(128, 365), Offset(170, 286)]));
    chordRecords.add(ChordRecord(chordName: "D_minor7", numberOfPoints: 2, inputVector: [Offset(329, 184), Offset(229, 269)]));
    
    chordRecords.add(ChordRecord(chordName: "A_major", numberOfPoints: 3, inputVector: [Offset(324, 289), Offset(245, 242),Offset(164, 231)]));
    chordRecords.add(ChordRecord(chordName: "A_major7", numberOfPoints: 3, inputVector: [Offset(170, 247), Offset(315, 218),Offset(238, 163)]));
    chordRecords.add(ChordRecord(chordName: "A_minor", numberOfPoints: 3, inputVector: [Offset(162, 236), Offset(238, 278),Offset(281, 132)]));
    chordRecords.add(ChordRecord(chordName: "C_major", numberOfPoints: 3, inputVector: [Offset(121, 354), Offset(165, 260),Offset(322, 127)]));
    chordRecords.add(ChordRecord(chordName: "D_major", numberOfPoints: 3, inputVector: [Offset(241, 237), Offset(347, 271),Offset(293, 386)]));
    chordRecords.add(ChordRecord(chordName: "D_7", numberOfPoints: 3, inputVector: [Offset(337, 274), Offset(284, 154),Offset(221, 251)]));
    chordRecords.add(ChordRecord(chordName: "D_minor", numberOfPoints: 3, inputVector: [Offset(225, 272), Offset(328, 169),Offset(314, 373)]));
    chordRecords.add(ChordRecord(chordName: "E_major", numberOfPoints: 3, inputVector: [Offset(95, 215), Offset(158, 273),Offset(228, 125)]));
    chordRecords.add(ChordRecord(chordName: "G_major", numberOfPoints: 3, inputVector: [Offset(82, 357), Offset(151, 282),Offset(318, 381)]));
    chordRecords.add(ChordRecord(chordName: "G_7", numberOfPoints: 3, inputVector: [Offset(82, 372), Offset(126, 290),Offset(352, 140)]));
    chordRecords.add(ChordRecord(chordName: "F_major7", numberOfPoints: 3, inputVector: [Offset(224, 321), Offset(258, 234),Offset(302, 145)]));
    
    chordRecords.add(ChordRecord(chordName: "B_7", numberOfPoints: 4, inputVector: [Offset(78, 240), Offset(134, 174),Offset(215, 277),Offset(324, 310)]));
    chordRecords.add(ChordRecord(chordName: "C_7", numberOfPoints: 4, inputVector: [Offset(148, 252), Offset(102, 350),Offset(253, 388),Offset(315, 144)]));
    chordRecords.add(ChordRecord(chordName: "F_major", numberOfPoints: 4, inputVector: [Offset(131, 310), Offset(108, 390),Offset(224, 244),Offset(92, 160)]));

    // //https://globalguitarnetwork.com/wp-content/uploads/2014/05/Open-Chords.png
    // setChordBy2Offset(cr_2points, "E_minor", Offset(106, 236), Offset(168, 296));
    // setChordBy2Offset(cr_2points, "E_7", Offset(106, 236), Offset(249, 161));
    // setChordBy2Offset(cr_2points, "A_7", Offset(177, 240), Offset(301, 280));
    // setChordBy2Offset(cr_2points, "A_minor7", Offset(177, 240), Offset(299, 152));
    // setChordBy2Offset(cr_2points, "C_major7", Offset(128, 365), Offset(170, 286));
    // setChordBy2Offset(cr_2points, "D_minor7", Offset(329, 184), Offset(229, 269));

    // setChordBy3Offset(cr_3points, "A_major", Offset(324, 289), Offset(245, 242),Offset(164, 231));
    // setChordBy3Offset(cr_3points, "A_major7", Offset(170, 247), Offset(315, 218),Offset(238, 163));
    // setChordBy3Offset(cr_3points, "A_minor", Offset(162, 236), Offset(238, 278),Offset(281, 132));
    // setChordBy3Offset(cr_3points, "C_major", Offset(121, 354), Offset(165, 260),Offset(322, 127));
    // setChordBy3Offset(cr_3points, "D_major", Offset(241, 237), Offset(347, 271),Offset(293, 386));
    // setChordBy3Offset(cr_3points, "D_7", Offset(337, 274), Offset(284, 154),Offset(221, 251));
    // setChordBy3Offset(cr_3points, "D_minor", Offset(225, 272), Offset(328, 169),Offset(314, 373));
    // setChordBy3Offset(cr_3points, "E_major", Offset(95, 215), Offset(158, 273),Offset(228, 125));
    // setChordBy3Offset(cr_3points, "G_major", Offset(82, 357), Offset(151, 282),Offset(318, 381));
    // setChordBy3Offset(cr_3points, "G_7", Offset(82, 372), Offset(126, 290),Offset(352, 140));
    // setChordBy3Offset(cr_3points, "F_major7", Offset(224, 321), Offset(258, 234),Offset(302, 145));

    // setChordBy4Offset(cr_4points, "B_7", Offset(78, 240), Offset(134, 174),Offset(215, 277),Offset(324, 310));
    // setChordBy4Offset(cr_4points, "C_7", Offset(148, 252), Offset(102, 350),Offset(253, 388),Offset(315, 144));
    // setChordBy4Offset(cr_4points, "F_major", Offset(131, 310), Offset(108, 390),Offset(224, 244),Offset(92, 160));


    
    store.loadRecords(chordRecords);
  }
 
  
  // void setChordBy3Offset(List<ChordRecord> cr_list, String name, Offset o1, Offset o2, Offset o3) {
  //   Map<int, Offset> points = {
  //     0 : o1,
  //     1 : o2,
  //     2 : o3,
  //   };
  //   List<Offset>? inputVector = convertToVector(points);
  //   if (inputVector != null) {
  //     ChordRecord cr = ChordRecord(chordName: name, numberOfPoints: 3, inputVector: inputVector);
  //     cr_list.add(cr);
  //   }
  // }
  // void setChordBy4Offset(List<ChordRecord> cr_list, String name, Offset o1, Offset o2, Offset o3, Offset o4) {
  //   Map<int, Offset> points = {
  //     0 : o1,
  //     1 : o2,
  //     2 : o3,
  //     3 : o4,
  //   };
  //   List<Offset>? inputVector = convertToVector(points);
  //   if (inputVector != null) {
  //     ChordRecord cr = ChordRecord(chordName: name, numberOfPoints: 4, inputVector: inputVector);
  //     cr_list.add(cr);
  //   }
  // }
}