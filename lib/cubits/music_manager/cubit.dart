import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_cloud_clone/components/constants.dart';
import 'package:sound_cloud_clone/cubits/login&Register/states.dart';
import 'package:sound_cloud_clone/cubits/music_manager/states.dart';
import 'package:sound_cloud_clone/models/playlist.dart';
import 'package:sound_cloud_clone/models/search_results.dart';

import '../../models/album_data.dart';
import '../../models/track_data.dart';
import '../../shared/network/remote/sound_api.dart';
import '../login&Register/cubit.dart';

class MusicManagerCubit extends Cubit<MusicManagerStates> {
  MusicManagerCubit() : super(SoundCloudMusicManagerInitialState());

  static MusicManagerCubit get(context) => BlocProvider.of(context);

  //the track list that is currently active (album, playlist... etc)
  List<TrackDataPlayback> trackList = [];
  //index of currently played track within the track list
  int playlistIndex = 0;
  //the track that is currently being played
  TrackDataPlayback nowPlaying = TrackDataPlayback();
  //boolean to indicate whether the playlist has been loaded and ready to be played
  bool playlistsLoaded = false;

  //function to use the API to get the track data and set it using the ID
  Future<void> getTrack(String id) async {
    emit(SoundCloudMusicManagerLoadingState());
    nowPlaying = await SoundAPI.getTrackAPI(id);
    emit(SoundCloudGetTrackSuccessState());
  }

  //function that validates the new playlist name and creates the playlist if valid
  void createPlaylist(String name) {
    for (Playlist lst in userPlaylists) {
      if (name == lst.name) {
        emit(SoundCloudAddPlaylistErrorState());
        return;
      }
    }
    userPlaylists.add(Playlist(name: name));
    emit(SoundCloudAddPlaylistSuccessState());
    updatePlaylists(); //updates the user playlists changes in database
  }

  List<Playlist> userPlaylists = [];

  //load playlists from data base into the cubit field: userPlaylists
  void loadPlayLists() {
    FirebaseFirestore.instance.collection('users').doc(loggedUserID).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        data["playlists"].forEach((element) {
          final json = element as Map<String, dynamic>;
          userPlaylists.add(Playlist.fromJson(json));
        });
        playlistsLoaded = true;
        emit(SoundCloudPlaylistsLoadedSuccessState());
      },
      onError: (e) {
        if (kDebugMode) {
          print("Error getting playlists $e");
        }
      },
    );
  }

  //function to update the user playlists in database after every addition/removal
  void updatePlaylists() {
    List<Map<String, dynamic>> sendJson = [];
    for (Playlist pl in userPlaylists) {
      sendJson.add(pl.toJson());
    }
    FirebaseFirestore.instance.collection('users').doc(loggedUserID).update({
      'playlists': sendJson,
    }).then((value) {
      emit(SoundCloudUpdatePlaylistSuccessState());
    }).catchError((error) {
      emit(SoundCloudUpdatePlaylistErrorState());
    });
  }


  AlbumData currentAlbum = AlbumData();
  void setAlbum(AlbumData album) {
    currentAlbum = album;
  }

  //get albums by search. which still has not been developed in UI of this version
  AlbumData getAlbum(String id) {
    AlbumData x = AlbumData();
    SoundAPI.getAlbumAPI(id).then((value) {
      x = value;
    });
    return x;
  }

  //object carrying the search results, contains the tracks for now
  //used by the search page to display the content
  /// in a later update, it may include other fields like albums and artists
  SearchResults searchResults = SearchResults();

  //function that gets the search response from API and initializes the searchResults object
  void setSearchResults(String searchQuery) {
    SoundAPI.getSearchResults(searchQuery).then((value) {
      searchResults = SearchResults.fromJson(value);
      emit(SoundCloudSearchSuccessState());
      },
      onError: (e){
        if (kDebugMode) {
          print('Search error : $e');
        }
        emit(SoundCloudSearchErrorState());
      }
    );
  }

  //boolean to indicate main screen content
  bool mainScreenContentLoaded = false;
  //list of albums displayed on the main screen
  List<AlbumData> mainScreenAlbums = [];
  //list of tracks displayed on the main screen
  List<TrackDataPlayback> mainScreenTracks = [];

  void loadMainScreenContent (){
    //to avoid loading them more than once
    if(mainScreenContentLoaded)
      {
        return;
      }
    mainScreenContentLoaded = true;

    //getting the default main screen content that is set in the database for all users
    FirebaseFirestore.instance.collection('preloaded_albums')
        .doc('albums').get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        data["main_screen_albums"].forEach((element) {
          final json = element as Map<String, dynamic>;
          mainScreenAlbums.add(AlbumData.fromJson(json));
          mainScreenTracks.addAll(mainScreenAlbums.last.trackList);
        });
        mainScreenTracks.shuffle();
        emit(SoundCloudMainScreenLoadedState());
        //emit(SoundCloudPlaylistsLoadedSuccessState());
      },
      onError: (e) {
        if (kDebugMode) {
          print("Error getting playlists $e");
        }
        // emit(SoundCloudPlaylistsLoadedErrorState());
        emit(SoundCloudMainScreenErrorState());
      },
    );
  }
}
