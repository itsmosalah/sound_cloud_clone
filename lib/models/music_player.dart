import 'package:just_audio/just_audio.dart';


//an object of this should be handled within the state management (BLOC / provider)
class MusicPlayer {
  bool isPlaying = false;
  bool urlSrcSet = false;
  String? urlSrc;
  var _audioPlayer;

  MusicPlayer(){
    isPlaying = urlSrcSet = false;
    _audioPlayer = AudioPlayer();
  }


  void setUrlSrc (String s) async {
    urlSrc = s;
    urlSrcSet = true;
    await _audioPlayer.setUrl(urlSrc);
  }

  void play() async {
    if (!isPlaying && urlSrcSet){
      //use the play method
      await _audioPlayer.play();
      isPlaying = true;
    }
  }

  void pause() async {
    //use the pause method

    isPlaying = false;
  }

  //going to add more fields for handling local music file handling
}