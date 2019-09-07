import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:utubefavs/models/video.dart';

import '../api.dart';

class VideosBloc implements BlocBase {

  Api api;

  List<Video> videos;

  final _videosController = StreamController();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController();
  Sink get inSearch => _searchController.sink;
  
  VideosBloc(){
    api = Api();

    _searchController.stream.listen(_search);
  }

  Future _search(search) async {
    if(search != null){
      _videosController.sink.add([]);
      videos = await api.search(search);
      _videosController.sink.add(videos);

    } else {

      videos += await api.nextPage();
      _videosController.sink.add(videos);

    }



  }

  @override
  void addListener(listener) {
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {
  }

  @override
  void removeListener(listener) {
  }



}