
import 'package:sound_cloud_clone/models/track_data.dart';

class Playlist {
  String name = "";
  int size = 0;
  List<TrackDataPlayback> trackList = [];

  Playlist({required this.name});

  Playlist.fromJson(Map<String,dynamic>json){
    size = json['no_of_tracks'];
    name = json['name'];
    for (int i = 0; i < size; i++){
      trackList.add(TrackDataPlayback.fromJson(json, index: i));
    }
  }

  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>>tracksJson = [];
    for (TrackDataPlayback track in trackList){
      tracksJson.add(track.toJson());
    }
    return {
      "name" : name,
      "no_of_tracks" : size,
      "tracks" : tracksJson
    };
  }

  void addTrack(TrackDataPlayback x){
    trackList.add(x);
    size++;
  }

  void removeTrack(int index){
    trackList.removeAt(index);
    size--;
  }
  /*
  planned json looks like so:

  {
    "name" : "myplaylist",
    "no_of_tracks" : 2,
    "tracks" : [

      tracks arranged the same way as in the API

    ]
  }


   */
}