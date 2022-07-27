import 'package:sound_cloud_clone/models/track_data.dart';

class SearchResults {
  List<TrackDataPreview> trackList = [];

  SearchResults.fromJson(Map<String, dynamic> json){
    json["tracks"]["items"].forEach((element){
      trackList.add(TrackDataPreview.fromJson(element["data"]));
    });
    print("HELLOO FINISHED");
  }

  SearchResults();
}