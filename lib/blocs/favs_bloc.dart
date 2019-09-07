import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utubefavs/models/video.dart';

class FavoriteBloc implements BlocBase{

  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFav => _favController.stream;

  void toggleFavorite(video){
    if(_favorites.containsKey(video.id)) _favorites.remove(video.id);
    else _favorites[video.id] = video;

    _favController.sink.add(_favorites); 

    _saveFav();
  }
  

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString('favorites', json.encode(_favorites));
    });
  }

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains('favorites')){
        _favorites = json.decode(prefs.getString('favorites')).map(
          (key, value){
            return MapEntry(key, Video.fromJson(value));
          }
        ).cast<String, Video>();

        _favController.add(_favorites);
      }
    });
  }





  // MÉTODOS
  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _favController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

}