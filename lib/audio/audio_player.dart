
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter/material.dart';


class AudioPlayer {
  // SoLoud C_maj = SoLoud.instance;
  // List<AudioSource?> C_maj_notes = List.filled(6, null);

  // Future<void> initialize() async {    //hàm khởi tạo để khởi tạo soloud và gán AudioSource
  //   await soloud.init();
  //   cellAudioSources[0] = await soloud.loadAsset('assets/sound_samples/E2-13-spn.wav');
  //   cellAudioSources[1] = await soloud.loadAsset('assets/sound_samples/C3-1-spn.wav');
  //   cellAudioSources[2] = await soloud.loadAsset('assets/sound_samples/E3-1-spn.wav');
  //   cellAudioSources[3] = await soloud.loadAsset('assets/sound_samples/G3-13-spn.wav');
  //   cellAudioSources[4] = await soloud.loadAsset('assets/sound_samples/C4-13-spn.wav');
  //   cellAudioSources[5] = await soloud.loadAsset('assets/sound_samples/E4-13-spn.wav');
  // }

  // SoLoud E_minor = SoLoud.instance;
  // SoLoud E_7 = SoLoud.instance;
  // SoLoud A_7 = SoLoud.instance;

  // SoLoud A_major = SoLoud.instance;
  // SoLoud A_minor = SoLoud.instance;
  // SoLoud C_major = SoLoud.instance;
  // SoLoud D_major = SoLoud.instance;
  // SoLoud D_7 = SoLoud.instance;
  // SoLoud D_minor = SoLoud.instance;
  // SoLoud E_major = SoLoud.instance;
  // SoLoud G_major = SoLoud.instance;
  // SoLoud G_7 = SoLoud.instance;
  // SoLoud F_major7 = SoLoud.instance;

  // SoLoud B_7 = SoLoud.instance;
  // SoLoud F_major = SoLoud.instance;
  // SoLoud B_minor = SoLoud.instance;

  SoLoud chords = SoLoud.instance;

  List<AudioSource> E_minor_notes = [];
  List<AudioSource> E_7_notes = [];
  List<AudioSource> A_7_notes = [];

  List<AudioSource> A_major_notes = [];
  List<AudioSource> A_minor_notes = [];
  List<AudioSource> C_major_notes = [];
  List<AudioSource> D_major_notes = [];
  List<AudioSource> D_7_notes = [];
  List<AudioSource> D_minor_notes = [];
  List<AudioSource> E_major_notes = [];
  List<AudioSource> G_major_notes = [];
  List<AudioSource> G_7_notes = [];
  List<AudioSource> F_major7_notes = [];

  List<AudioSource> B_7_notes = [];
  List<AudioSource> F_major_notes = [];
  List<AudioSource> B_minor_notes = [];

  Map<String, List<AudioSource>> notes = {};

  Future<void> initialize() async {
    // await E_minor.init();
    // await E_7.init();
    // await A_7.init();

    // await A_major.init();
    // await A_minor.init();
    // await C_major.init();
    // await D_major.init();
    // await D_7.init();
    // await D_minor.init();
    // await E_major.init();
    // await G_major.init();
    // await G_7.init();
    // await F_major7.init();

    // await B_7.init();
    // await F_major.init();
    // await B_minor.init();
    await chords.init();

    // E_minor_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // E_7_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // A_7_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // A_major_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // A_minor_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // C_major_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // D_major_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // D_7_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // D_minor_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // E_major_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // G_major_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // G_7_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // F_major7_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // B_7_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // F_major_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    // B_minor_notes.addAll([
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    //   await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
    // ]);
    E_minor_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/G3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    E_7_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Gsharp3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    A_7_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/G3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Csharp4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    A_major_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Csharp4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    A_minor_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    C_major_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/G3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    D_major_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Fsharp4-7-spn.wav'),
    ]);
    D_7_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Fsharp4-7-spn.wav'),
    ]);
    D_minor_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/F4-13-spn.wav'),
    ]);
    E_major_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Gsharp3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    G_major_notes.addAll([
      await chords.loadAsset('assets/sound_samples/G2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/G3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/G4-7-spn.wav'),
    ]);
    G_7_notes.addAll([
      await chords.loadAsset('assets/sound_samples/G2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/G3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/F4-13-spn.wav'),
    ]);
    F_major7_notes.addAll([
      await chords.loadAsset('assets/sound_samples/F2-7-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/F3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/E4-13-spn.wav'),
    ]);
    B_7_notes.addAll([
      await chords.loadAsset('assets/sound_samples/E2-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Dsharp3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Fsharp4-7-spn.wav'),
    ]);
    F_major_notes.addAll([
      await chords.loadAsset('assets/sound_samples/F2-7-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C3-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/F3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/A3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/C4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/F4-13-spn.wav'),
    ]);
    B_minor_notes.addAll([
      await chords.loadAsset('assets/sound_samples/Fsharp2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B2-1-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Fsharp3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/B3-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/D4-13-spn.wav'),
      await chords.loadAsset('assets/sound_samples/Fsharp4-7-spn.wav'),
    ]);


    notes = {
      "E_minor" : E_minor_notes,
      "E_7" : E_7_notes,
      "A_7" : A_7_notes,
      "A_major" : A_major_notes,
      "A_minor" : A_minor_notes,
      "C_major" : C_major_notes,
      "D_major" : D_major_notes,
      "D_7" : D_7_notes,
      "D_minor" : D_minor_notes,
      "E_major" : E_major_notes,
      "G_major" : G_major_notes,
      "G_7" : G_7_notes,
      "F_major7" : F_major7_notes,
      "B_7" : B_7_notes,
      "F_major" : F_major_notes,
      "B_minor" : B_minor_notes,
    };

  }


  void dispose() {
    chords.deinit();
  }

  void playSoundForCell(String chordName, int stringNumber) {        //nhận thông tin là tên của chordRecord gần nhất và sợi đây được gẩy (0-5)
    // AudioSource? source = cellAudioSources[index];
    // if (source != null) {
    //   soloud.play(source);
    // }
    // switch (chordName) {
    //   case "E_minor":
    // }

    for (int i = 0; i < notes.length; i++) {
      if (notes.keys.elementAt(i) == chordName) {
        AudioSource source = notes.values.elementAt(i).elementAt(stringNumber);
        chords.play(source);
        break;
      }
      
    }
  }

  
}