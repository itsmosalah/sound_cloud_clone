import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sound_cloud_clone/models/album_data.dart';
import '../../../models/track_data.dart';

class SoundAPI {

  static Map<String,dynamic> headerValues = {
    'X-RapidAPI-Key' : "ecd058c83cmsh153109f65a006a2p18cbd8jsn937e9f50b68e",
    'X-RapidAPI-Host': 'spotify23.p.rapidapi.com',
  };

  static Dio _dio = Dio();


  static Future<String> getResponse(String endpoint_params) async {
    String url = "https://spotify23.p.rapidapi.com/$endpoint_params";
    Response res = await _dio.get(
      url,
      options: Options(
        headers: headerValues,
        responseType: ResponseType.plain,
      ),
    );

    return res.data.toString();
  }

  static Future<TrackDataPlayback> getTrackAPI(String trackID) async {


    String getTrackResponse = await getResponse("tracks/?ids=$trackID");

    Map<String,dynamic> data = await json.decode(getTrackResponse);


    return TrackDataPlayback.fromJson(data);
  }


  static Future<Map<String,dynamic>> getSearchResults(String searchQuery) async {

    String responseSearch = await getResponse("search/?q=%3C$searchQuery%3E&type=multi&offset=0&limit=10&numberOfTopResults=7");

    Map<String,dynamic> data = await json.decode(responseSearch);

    return data;
  }

  static Future<AlbumData> getAlbumAPI(String id) async {
    String getAlbumResponse = await getResponse("albums/?ids=$id");

    Map<String,dynamic> data = await json.decode(getAlbumResponse);

    return AlbumData.fromJson(data["albums"][0]);
  }
}