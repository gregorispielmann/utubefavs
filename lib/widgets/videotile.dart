import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:utubefavs/blocs/favs_bloc.dart';
import 'package:utubefavs/models/video.dart';

class VideoTile extends StatelessWidget {
  
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10,5,10,5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          AspectRatio(
          aspectRatio: 16/9,
          child: Image.network(video.thumb, fit: BoxFit.cover),
        ),
        Row(children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(video.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 2,),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,0,10,10),
                child: Text(video.channel, style: TextStyle(color: Colors.white, fontSize: 12),),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
            )
          ),
          StreamBuilder(
            stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
            builder: (context,snapshot){
              if(snapshot.hasData){
                return IconButton(
                    icon: Icon(snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border, size: 30, color: Colors.white,),
                    onPressed: (){
                      BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(video);
                    },
                  );
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )
        ],)
        ],)
    );
  }
}