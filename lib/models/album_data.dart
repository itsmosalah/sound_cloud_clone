import 'package:sound_cloud_clone/models/track_data.dart';

class AlbumData {
  List<TrackDataPlayback> trackList = [];
  String name = "", id = "", label = "";
  int size = 0;
  String image640URL = "", image300URL = "", image64URL = "", releaseDate = "";


  //recieved json["albums"][0]
  AlbumData.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    image640URL = json["images"][0]["url"];
    image300URL = json["images"][1]["url"];
    image64URL = json["images"][2]["url"];
    label = json["label"];
    releaseDate = json["release_date"];
    json["tracks"]["items"].forEach((element){
      trackList.add(TrackDataPlayback.fromAlbumJson(element, [
        image640URL, image300URL, image64URL
      ]));
      trackList.last.albumName = name;
    });
  }

  AlbumData();
}