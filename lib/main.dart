import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:utubefavs/blocs/favs_bloc.dart';
import 'package:utubefavs/blocs/videos_bloc.dart';

import 'api.dart';
import 'screens/home.dart';

void main() {

  Api api = Api();
  api.search('samsung');

  runApp(App());

}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      child: MaterialApp(
        title: 'uTube Favs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: Home(),
      ),
    );
  }
}
