import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:utubefavs/api.dart';
import 'package:utubefavs/blocs/favs_bloc.dart';
import 'package:utubefavs/models/video.dart';

class Favorites extends StatelessWidget {

  final bloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context,snapshot){
          return ListView(
            children: snapshot.data.values.map((v){
              return InkWell(
                onTap: (){
                  FlutterYoutube.playYoutubeVideoById(
                    apiKey: API_key,
                    videoId: v.id,
                  );
                },
                onLongPress: () { bloc.toggleFavorite(v); }, 
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),


                  Expanded(
                    child: Text(v.title, style: TextStyle(color: Colors.white),),

                  ),],
                ),
              );
            }).toList()
          );
        },
      ),
    );
  }
}