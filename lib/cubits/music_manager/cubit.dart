
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';

import '../../models/track_data.dart';
import '../../shared/network/remote/sound_api.dart';

class SoundCloudMusicManagerCubit extends Cubit<SoundCloudMusicManagerStates> {
  SoundCloudMusicManagerCubit() : super(SoundCloudMusicManagerInitialState());

  static SoundCloudMusicManagerCubit get(context) => BlocProvider.of(context);



  List<TrackDataPreview> trackList = [];

  void setTrackList ()  {
    SoundAPI api = SoundAPI();
    // Map<String,dynamic> mp =
    api.getSearchResults("ay 7aga").then((value) {
      trackList = getTrackList(value);
    });
  }

  TrackDataPlayback nowPlaying = TrackDataPlayback.fromJson({"init":"init"});

  void setNowPlaying(){
    emit(SoundCloudMusicManagerLoadingState());
    SoundAPI api = SoundAPI();
    api.getTrack("id").then((value) {
      nowPlaying = value;
      emit(SoundCloudPlayingNowState());
    });

  }


  IconData playerButtonIcon = Icons.play_arrow;
  bool isPlaying = false;
  bool urlSrcSet = false;
  String urlSrc = "";
  AudioPlayer audioPlayer = AudioPlayer();

  int duration = 30;

  void slideTo(double newPosition)  {
     audioPlayer.seek(Duration(seconds: newPosition.toInt()));
    emit(SoundCloudMoveSliderState());
  }

  int getPosition(){
    int value = audioPlayer.position.inSeconds;
    return value;
  }

  void togglePlayer()  {
    if (!isPlaying){
       audioPlayer.play();
      playerButtonIcon = Icons.pause;
      emit(SoundCloudPlayingNowState());
    }
    else{
       audioPlayer.pause();
      playerButtonIcon = Icons.play_arrow;
      emit(SoundCloudPausedState());
    }
    isPlaying = !isPlaying;
  }

  void setUrlSrc (String s) async {
    urlSrc = s; urlSrcSet = true;
    await audioPlayer.setUrl(urlSrc);
    duration = audioPlayer.duration!.inSeconds;
  }

  void fastForward(int value){
    int pos = getPosition();
    if (pos+value >= duration){
      togglePlayer();
      slideTo(0);
    }
    else {
      slideTo((pos + value).toDouble());
    }
  }

  void rewind(int value){
    int pos = getPosition();
    if (pos - value <= 0){
      slideTo(0);
    }
    else {
      slideTo((pos-value).toDouble());
    }
  }

  int speedIdx = 0;
  List<double>speeds = [1, 1.25, 1.5, 1.75, 2];
  void cycleSpeed(){
    speedIdx++;
    if (speedIdx == speeds.length) speedIdx = 0; //faster than modulo
    audioPlayer.setSpeed(speeds[speedIdx]);
  }

  double getCurrentSpeed() => speeds[speedIdx];

//going to add more fields for handling local music file handling


}
