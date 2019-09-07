import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:utubefavs/blocs/favs_bloc.dart';
import 'package:utubefavs/blocs/videos_bloc.dart';
import 'package:utubefavs/delegates/search.dart';
import 'package:utubefavs/screens/favorites.dart';
import 'package:utubefavs/widgets/videotile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          child: Image.asset('images/ytlogo.png'),
          height: 25,
        ),
        elevation: 0,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              initialData: {},
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return Text('${snapshot.data.length}');
                } else {
                  return Text('0');
                }
              },
            )
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              var result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
            },
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: StreamBuilder(
          stream: BlocProvider.getBloc<VideosBloc>().outVideos,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: Text('Faça uma pesquisa!', style: TextStyle(color: Colors.white, fontSize: 16),),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index){
                  if(index < snapshot.data.length){
                    return VideoTile(
                      snapshot.data[index]
                    );
                  } else if(index > 1){
                    BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red),),
                    );
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            }
          },
        ),
        )
      );
  }
}