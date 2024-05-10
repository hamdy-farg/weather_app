import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/busseniss%20logic/bloc/weather_bloc.dart';
import 'package:wheather_app/busseniss%20logic/notes/bloc/note_bloc.dart';
import 'package:wheather_app/presintation/home_page.dart';

void main() {
  runApp(const MyWheatherApp());
}

class MyWheatherApp extends StatelessWidget {
  const MyWheatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NoteBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => WeatherBloc(),
            child: Container(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePageState(),
        ));
  }
}
