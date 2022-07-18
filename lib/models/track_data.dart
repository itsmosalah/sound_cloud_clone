class TrackData {
  String id= "", name = "", previewURL = "";

  //url to images with different resolutions
  String? image640URL, image300URL, image64URL, albumName;

  // TrackData({required this.id,required this.name,required this.previewURL});

  TrackData.fromJson(Map <String, dynamic> json){
    id = json["tracks"][0]["id"];
    name = json["tracks"][0]["name"];
    previewURL = json["tracks"][0]["preview_url"];
  }
}