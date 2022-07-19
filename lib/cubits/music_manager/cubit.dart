
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
  AudioPlayer _audioPlayer = AudioPlayer();


  void togglePlayer()  {
    if (!isPlaying){
       _audioPlayer.play();
      playerButtonIcon = Icons.pause;
      emit(SoundCloudPlayingNowState());
    }
    else {
       _audioPlayer.pause();
      playerButtonIcon = Icons.play_arrow;
      emit(SoundCloudPausedState());
    }
    isPlaying = !isPlaying;
  }

  void setUrlSrc (String s) async {
    urlSrc = s;
    urlSrcSet = true;
    await _audioPlayer.setUrl(urlSrc);
  }



//going to add more fields for handling local music file handling


}
