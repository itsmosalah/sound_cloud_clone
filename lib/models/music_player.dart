import 'package:just_audio/just_audio.dart';


//an object of this should be handled within the state management (BLOC / provider)
class MusicPlayer {
  bool isPlaying = false;
  bool urlSrcSet = false;
  String urlSrc = "";
  final _audioPlayer = AudioPlayer();

  MusicPlayer(){
    isPlaying = urlSrcSet = false;
  }

  void setUrlSrc (String s) async {
    urlSrc = s;
    urlSrcSet = true;
    await _audioPlayer.setUrl(urlSrc);
  }
}