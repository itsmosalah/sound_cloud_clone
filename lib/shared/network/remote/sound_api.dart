import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:sound_cloud_clone/models/album_data.dart';
import '../../../models/track_data.dart';

class SoundAPI {

  //initializing the API request header values.
  //retrieving the API key from the environment variables
  static Map<String,dynamic> headerValues = {
    'X-RapidAPI-Key' : dotenv.env['API_KEY'],
    'X-RapidAPI-Host': 'spotify23.p.rapidapi.com',
  };

  static final Dio _dio = Dio();

  //function that takes the endpoint parameters (search by search key, tracks by id.. etc)
  //and returns the response
  static Future<String> getResponse(String endpointParams) async {
    String url = "https://spotify23.p.rapidapi.com/$endpointParams";
    Response res = await _dio.get(
      url,
      options: Options(
        headers: headerValues,
        responseType: ResponseType.plain,
      ),
    );
    return res.data.toString();
  }

  //get the track data from API using the given track ID
  static Future<TrackDataPlayback> getTrackAPI(String trackID) async {

    String getTrackResponse = await getResponse("tracks/?ids=$trackID");

    Map<String,dynamic> data = await json.decode(getTrackResponse);

    return TrackDataPlayback.fromJson(data);
  }


  //get search results given the search string. with fixed query parameters
  static Future<Map<String,dynamic>> getSearchResults(String searchQuery) async {

    int numberOfResults = 7, offset = 0, limit = 10;
    String type = 'multi';

    String responseSearch =
      await getResponse("search/?q=%3C$searchQuery%3E&type=$type&offset=$offset&limit=$limit&numberOfTopResults=$numberOfResults");

    Map<String,dynamic> data = await json.decode(responseSearch);

    return data;
  }

  //function to get the album by ID.
  /// this option is currently not developed in the rest of the application
  static Future<AlbumData> getAlbumAPI(String id) async {
    String getAlbumResponse = await getResponse("albums/?ids=$id");

    Map<String,dynamic> data = await json.decode(getAlbumResponse);

    return AlbumData.fromJson(data["albums"][0]);
  }
}