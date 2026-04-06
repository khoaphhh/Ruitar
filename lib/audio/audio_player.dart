
import 'package:flutter_soloud/flutter_soloud.dart';


class AudioPlayer {
  SoLoud soloud = SoLoud.instance;
  List<AudioSource?> cellAudioSources = List.filled(6, null);

  Future<void> initialize() async {    //hàm khởi tạo để khởi tạo soloud và gán AudioSource
    await soloud.init();
    cellAudioSources[0] = await soloud.loadAsset('assets/sound_samples/E2-13-spn.wav');
    cellAudioSources[1] = await soloud.loadAsset('assets/sound_samples/C3-1-spn.wav');
    cellAudioSources[2] = await soloud.loadAsset('assets/sound_samples/E3-1-spn.wav');
    cellAudioSources[3] = await soloud.loadAsset('assets/sound_samples/G3-13-spn.wav');
    cellAudioSources[4] = await soloud.loadAsset('assets/sound_samples/C4-13-spn.wav');
    cellAudioSources[5] = await soloud.loadAsset('assets/sound_samples/E4-13-spn.wav');
  }

  void dispose() {
    soloud.deinit();
  }

  void playSoundForCell(int index) {        //nhận thông tin là tên của chordRecord gần nhất và sợi đây được gẩy (0-5)
    AudioSource? source = cellAudioSources[index];
    if (source != null) {
      soloud.play(source);
    }
  }

  
}