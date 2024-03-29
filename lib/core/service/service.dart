import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ws_flutter_fetchapi/core/model/movie_resp.dart';
import 'package:ws_flutter_fetchapi/core/model/movie_response.dart';

class Service {
  String nowPlayingUrl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=befc21d948862259da6f029c54831a9c&language=en-US&page=1';

  String upComingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=befc21d948862259da6f029c54831a9c&language=en-US&page=1';

  Future<MovieResponse> getNowPlaying() async {
    try {
      print('Request : $nowPlayingUrl');

      final response = await http.get(nowPlayingUrl);

      if (response.statusCode == 200) {
        Map json = jsonDecode(response.body);
        print('Response : ' + json.toString());

        MovieResponse movieResponse = MovieResponse.fromJson(json);
        return movieResponse;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<MovieResp> getUpcoming() async{
    try{
      print('Request : $upComingUrl');
      final response = await http.get(upComingUrl);
      if(response.statusCode == 200){
        Map json = jsonDecode(response.body);
        print('responsenya : ' + json.toString());

        MovieResp movieResp = MovieResp.fromJson(json);
        return movieResp;
      }else{
        print('failed');
      }
    }catch(e){
        print(e.toString());
    }
  }
}
