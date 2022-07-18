import 'package:dio/dio.dart';

class SoundAPI {

  var _dio;

  SoundAPI() {
    _dio = Dio();
  }

  //for testing use
  // getResponse("search", "q=%3CREQUIRED%3E&type=multi&offset=0&limit=10&numberOfTopResults=5");


  Future<String> getResponse(String endPoint, String queryParams) async {
    //                                      base address
    Response res = await _dio.get("https://spotify23.p.rapidapi.com/$endPoint/?$queryParams" ,
      options: Options(
        headers: {
          'X-RapidAPI-Key' : "ecd058c83cmsh153109f65a006a2p18cbd8jsn937e9f50b68e",
          'X-RapidAPI-Host': 'spotify23.p.rapidapi.com',
        },
      ),);
    return res.data.toString();
  }

}