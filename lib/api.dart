import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:utubefavs/models/video.dart';

const API_key = 'AIzaSyARsuIDEpZozM2_tHJII9nAViiUgtXzg7A';

class Api {

  String _search;
  String _nextToken;

  search(search) async {

    http.Response res = await http.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_key&maxResults=3"
    );

    _search = search;

    return decode(res);

  }

  nextPage() async {

      http.Response res = await http.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_key&maxResults=3&pageToken=$_nextToken"
    );

    return decode(res);
  }

  decode(res){
    if(res.statusCode == 200){

      var decoded = json.decode(res.body);

      _nextToken = decoded['nextPageToken'];

      List<Video> videos = decoded['items'].map<Video>(
        (map){
          return Video.fromJson(map);
        }
      ).toList();

      return videos;

    } else {
      throw Exception('Failed to load videos');
      
    }
  }

}



// "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"


// "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
