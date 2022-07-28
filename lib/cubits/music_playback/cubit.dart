import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_cloud_clone/cubits/music_manager/cubit.dart';
import 'package:sound_cloud_clone/cubits/music_playback/states.dart';
import 'package:sound_cloud_clone/models/track_data.dart';

import '../../components/constants.dart';
import '../../models/playlist.dart';

class MusicPlaybackCubit extends Cubit<MusicPlaybackStates> {
  MusicPlaybackCubit() : super(MusicPlaybackInitialState());

  static MusicPlaybackCubit get(context) => BlocProvider.of(context);


  ///PLAYLIST MODE - TESTING

  //set active playlist
  //set index of current track in active
  List<TrackDataPlayback> activePlaylist = [];
  int playlistIndex = 0;

  void setActivePlaylist (List <TrackDataPlayback> lst, int curIndex){
    activePlaylist = lst;
    playlistIndex = curIndex;
  }

  //next track
  void nextTrack(){
    if (playlistIndex == activePlaylist.length - 1){
      playlistIndex = 0;
    }
    else {
      playlistIndex++;
    }

    setActiveTrack(activePlaylist[playlistIndex]);
    emit(MusicPlaybackPlaylistNavigationState());

    togglePlayer();
  }

  //previous track
  void previousTrack(){
    if (playlistIndex == 0){
      playlistIndex = activePlaylist.length - 1;
    }
    else {
      playlistIndex--;
    }
    setActiveTrack(activePlaylist[playlistIndex]);
    emit(MusicPlaybackPlaylistNavigationState());
  }



  //testing
  void navigatePanel(){
    stillPlaying = !stillPlaying;
    emit(MusicPlaybackStillPlayingState());
  }

  TrackDataPlayback activeTrack = TrackDataPlayback();
  bool activeTrackSet = false;
  void setActiveTrack(TrackDataPlayback track){
    activeTrackSet = true;
    activeTrack = track;
    if (isPlaying){
      togglePlayer();
    }
    setUrlSrc(track.previewURL);
    //togglePlayer();
  }

  bool stillPlaying = false;
  IconData playerButtonIcon = Icons.play_arrow;
  bool isPlaying = false;

  String urlSrc = "";
  AudioPlayer audioPlayer = AudioPlayer();
  int duration = 0;

  void slideTo(double newPosition) {
    audioPlayer.seek(Duration(seconds: newPosition.toInt()));
    emit(MusicPlaybackMoveSliderState());
  }

  int getPosition() {
    int value = audioPlayer.position.inSeconds;
    emit(MusicPlaybackGetPositionState());

    if (value == audioPlayer.duration?.inSeconds){
      if (activePlaylist.isNotEmpty){
        nextTrack();
      }
    }

    return value;
  }

  void togglePlayer() {
    if (!isPlaying) {
      audioPlayer.play();
      playerButtonIcon = Icons.pause;
      emit(MusicPlaybackPlaySuccessState());
    } else {
      audioPlayer.pause();
      playerButtonIcon = Icons.play_arrow;
      emit(MusicPlaybackPauseSuccessState());
    }
    isPlaying = !isPlaying;
  }

  Future<void> setUrlSrc(String s) async {
    urlSrc = s;
    await audioPlayer.setUrl(urlSrc);
    duration = audioPlayer.duration!.inSeconds;
  }

  void fastForward(int value) {
    int pos = getPosition();
    if (pos + value >= duration) {
      if (isPlaying) togglePlayer();
      slideTo(0);
    } else {
      slideTo((pos + value).toDouble());
    }
  }

  void rewind(int value) {
    int pos = getPosition();
    if (pos - value <= 0) {
      slideTo(0);
    } else {
      slideTo((pos - value).toDouble());
    }
  }

  int speedIdx = 0;
  List<double> speeds = [1, 1.25, 1.5, 1.75, 2];

  void cycleSpeed() {
    speedIdx++;
    if (speedIdx == speeds.length) speedIdx = 0; //faster than modulo
    audioPlayer.setSpeed(speeds[speedIdx]);
  }

  double getCurrentSpeed() => speeds[speedIdx];

}