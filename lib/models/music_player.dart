class MusicPlayer {
  bool isPlaying = false;
  bool srcSet = false;
  String? src;

  MusicPlayer(){
    isPlaying = srcSet = false;
  }


  void setSrc (String s){
    src = s;
    srcSet = true;
  }

  void play() async {
    if (!isPlaying && srcSet){
      //use the play method

      isPlaying = true;
    }
  }

  void pause() async {
    //use the pause method

    isPlaying = false;
  }

}