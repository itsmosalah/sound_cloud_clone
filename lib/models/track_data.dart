abstract class TrackData {
  String id = "", name = "", artistName = "";

  //url to images with different resolutions
  String image640URL = "", image300URL = "", image64URL = "", albumName = "";

  // TrackData({required this.id,required this.name,required this.previewURL});
}

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

class TrackDataPlayback extends TrackData {
  String previewURL = "";
  TrackDataPlayback.fromJson(Map <String, dynamic> json){
    if (json["init"]=="init") {
      return;
    }
    id = json["tracks"][0]["id"];
    name = json["tracks"][0]["name"];
    previewURL = json["tracks"][0]["preview_url"];
    image640URL = json["tracks"][0]["album"]["images"][0]["url"];
    image300URL = json["tracks"][0]["album"]["images"][1]["url"];
    image64URL = json["tracks"][0]["album"]["images"][2]["url"];
    albumName = json["tracks"][0]["album"]["name"];
    artistName = json["tracks"][0]["artists"][0]["name"];

  }
}

/*
  got a json,
  make a list of trackpreview
 */


List<TrackDataPreview> getTrackList (Map<String,dynamic>json){
  var jsonList = json["tracks"]["items"];

  List<TrackDataPreview> trackList = [];

  for (var element in jsonList) {
    trackList.add(
        TrackDataPreview.fromJson(element["data"])
    );
  }

  return trackList;
}

/*
class TrackList {
  List? trackList;
  TrackList.fromJson(Map<String,dynamic>json){
    List<Map<String, dynamic>> jsonList = json["tracks"]["items"];
    for (var element in jsonList) {
      trackList?.add(
          TrackDataPreview.fromJson(element["data"])
      );
    }
  }
}*/
