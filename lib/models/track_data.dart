abstract class TrackData {
  String id = "", name = "", artistName = "";

  //url to images with different resolutions
  String image640URL = "", image300URL = "", image64URL = "", albumName = "";

}

/*
  as the json for tracks retrieved from searchQuery is different
  from the json received from getTrack for the currently used API

  we made them into two separate classes.
 */

//track data only for preview. used in displaying search results
class TrackDataPreview extends TrackData {
  TrackDataPreview.fromJson(Map <String, dynamic> json){
    id = json["id"];
    name = json["name"];
    image300URL = json["albumOfTrack"]["coverArt"]["sources"][0]["url"];
    image64URL = json["albumOfTrack"]["coverArt"]["sources"][1]["url"];
    image640URL = json["albumOfTrack"]["coverArt"]["sources"][2]["url"];
    artistName = json["artists"]["items"][0]["profile"]["name"];
    albumName = json["albumOfTrack"]["name"];
  }
}

//track data that is available to be played (includes a URL)
class TrackDataPlayback extends TrackData {
  String previewURL = "";
  TrackDataPlayback.fromJson(Map <String, dynamic> json, {int? index = 0}){
    id = json["tracks"][index]["id"];
    name = json["tracks"][index]["name"];
    previewURL = json["tracks"][index]["preview_url"];
    image640URL = json["tracks"][index]["album"]["images"][0]["url"];
    image300URL = json["tracks"][index]["album"]["images"][1]["url"];
    image64URL = json["tracks"][index]["album"]["images"][2]["url"];
    albumName = json["tracks"][index]["album"]["name"];
    artistName = json["tracks"][index]["artists"][0]["name"];

  }
  TrackDataPlayback();
  Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "name" : name,
      "album" : {
        "images" : [
          {"url" : image640URL},
          {"url" : image300URL},
          {"url" : image64URL}
        ],
        "name" : albumName,
      },
      "preview_url" : previewURL,
      "artists" : [{"name" : artistName}]
    };
  }


  TrackDataPlayback.fromAlbumJson(Map <String, dynamic> json, List<String>images){
    id = json["id"];
    previewURL = json["preview_url"];
    name = json["name"];
    artistName = json["artists"][0]["name"];
    image640URL = images[0];
    image300URL = images[0];
    image64URL = images[0];
    name.replaceAll("\"", " ");
  }

}

// given json for the track list retrieved from albums, returns a list of track objects
List<TrackDataPreview> getTrackList (Map<String,dynamic>json){
  final jsonList = json["tracks"]["items"];

  List<TrackDataPreview> trackList = [];

  for (var element in jsonList) {
    trackList.add(
        TrackDataPreview.fromJson(element["data"])
    );
  }

  return trackList;
}

