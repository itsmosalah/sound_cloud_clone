
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/models/playlist.dart';

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
    //this should take the track id string
    //and then it should check the set of loaded tracks

    emit(SoundCloudMusicManagerLoadingState());
    SoundAPI api = SoundAPI();
    //if not loaded already, request it from api
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
      if (isPlaying) togglePlayer();
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

  List<Playlist>userPlaylists = [];

  void loadPlayLists(){
    //this should load the playlists from the firebase
    //load playlists in a list of map where each map corresponds to a playlist

    //this should be the ONE OF THE json we receive after decoding it
    //a json containing a single playlist
    String jsonStr = "{\"name\":\"myplaylist\",\"no_of_tracks\":2,\"tracks\":[{\"album\":{\"album_type\":\"album\",\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"external_urls\":{\"spotify\":\"https://open.spotify.com/album/4K3AXbUoyTVE4A6wV50cmB\"},\"id\":\"4K3AXbUoyTVE4A6wV50cmB\",\"images\":[{\"height\":640,\"url\":\"https://i.scdn.co/image/ab67616d0000b2735f3afe4cafb7a274497341b3\",\"width\":640},{\"height\":300,\"url\":\"https://i.scdn.co/image/ab67616d00001e025f3afe4cafb7a274497341b3\",\"width\":300},{\"height\":64,\"url\":\"https://i.scdn.co/image/ab67616d000048515f3afe4cafb7a274497341b3\",\"width\":64}],\"name\":\"Horizons\",\"release_date\":\"2014-08-12\",\"release_date_precision\":\"day\",\"total_tracks\":10,\"type\":\"album\",\"uri\":\"spotify:album:4K3AXbUoyTVE4A6wV50cmB\"},\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"disc_number\":1,\"duration_ms\":198386,\"explicit\":false,\"external_ids\":{\"isrc\":\"QMF921450124\"},\"external_urls\":{\"spotify\":\"https://open.spotify.com/track/3nBmy2hAqIDmMOD0VZGB7I\"},\"id\":\"3nBmy2hAqIDmMOD0VZGB7I\",\"is_local\":false,\"is_playable\":true,\"name\":\"Lost\",\"popularity\":45,\"preview_url\":\"https://p.scdn.co/mp3-preview/6574de68d560b54a86d76b56ea5a414241627106?cid=f6a40776580943a7bc5173125a1e8832\",\"track_number\":5,\"type\":\"track\",\"uri\":\"spotify:track:3nBmy2hAqIDmMOD0VZGB7I\"},{\"album\":{\"album_type\":\"album\",\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"external_urls\":{\"spotify\":\"https://open.spotify.com/album/4K3AXbUoyTVE4A6wV50cmB\"},\"id\":\"4K3AXbUoyTVE4A6wV50cmB\",\"images\":[{\"height\":640,\"url\":\"https://i.scdn.co/image/ab67616d0000b2735f3afe4cafb7a274497341b3\",\"width\":640},{\"height\":300,\"url\":\"https://i.scdn.co/image/ab67616d00001e025f3afe4cafb7a274497341b3\",\"width\":300},{\"height\":64,\"url\":\"https://i.scdn.co/image/ab67616d000048515f3afe4cafb7a274497341b3\",\"width\":64}],\"name\":\"Horizons\",\"release_date\":\"2014-08-12\",\"release_date_precision\":\"day\",\"total_tracks\":10,\"type\":\"album\",\"uri\":\"spotify:album:4K3AXbUoyTVE4A6wV50cmB\"},\"artists\":[{\"external_urls\":{\"spotify\":\"https://open.spotify.com/artist/2zwHaEmXxX6DTv4i8ajNCM\"},\"id\":\"2zwHaEmXxX6DTv4i8ajNCM\",\"name\":\"KrisAllen\",\"type\":\"artist\",\"uri\":\"spotify:artist:2zwHaEmXxX6DTv4i8ajNCM\"}],\"disc_number\":1,\"duration_ms\":198386,\"explicit\":false,\"external_ids\":{\"isrc\":\"QMF921450124\"},\"external_urls\":{\"spotify\":\"https://open.spotify.com/track/3nBmy2hAqIDmMOD0VZGB7I\"},\"id\":\"3nBmy2hAqIDmMOD0VZGB7I\",\"is_local\":false,\"is_playable\":true,\"name\":\"Lost\",\"popularity\":45,\"preview_url\":\"https://p.scdn.co/mp3-preview/6574de68d560b54a86d76b56ea5a414241627106?cid=f6a40776580943a7bc5173125a1e8832\",\"track_number\":5,\"type\":\"track\",\"uri\":\"spotify:track:3nBmy2hAqIDmMOD0VZGB7I\"}]}";

    Map<String,dynamic> data = jsonDecode(jsonStr);
    userPlaylists.add(Playlist.fromJson(data));
  }
}
