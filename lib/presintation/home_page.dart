import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather_app/busseniss%20logic/bloc/weather_bloc.dart';
import 'package:wheather_app/busseniss%20logic/notes/bloc/note_bloc.dart';
import 'package:wheather_app/constats/weather_data.dart';
import 'package:wheather_app/presintation/add_note.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomePageState extends StatelessWidget {
  HomePageState({super.key});

  @override
  Widget build(BuildContext context) {
    // weather bloc provider state of the weather in this screen
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    // note bloc provider state of the note in this screen
    NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
    weatherBloc.add(GetWeather());
    return Scaffold(
      // app bar of the screen
      appBar: AppBar(
        title: Text(
          "Todays Weather",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // our builder to build specific location on the screen
                BlocBuilder<WeatherBloc, WeatherState>(
                  bloc: BlocProvider.of<WeatherBloc>(context),
                  builder: (context, state) {
                    // if (state is weatherLoading state) go to make loading
                    // else if (state is weatherLoaded state ) display the info
                    // else if (state is weatherError ) display the error
                    return state is WeatherLoading
                        ? Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          )
                        : state is WeatherLoaded
                            ? Container(
                                height: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 150,
                                      child: Lottie.asset(
                                        WeatherSwetch().getWeatherAnimation(
                                            (state as WeatherLoaded)
                                                .weatherModel
                                                .mainConditoin),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.weatherModel.city_name,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${(state as WeatherLoaded).weatherModel.temp} *C",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : state is WeatherError
                                ? Container(
                                    height: 300,
                                    child: Center(
                                        child: Text(
                                      "you must have internet connection \nto get current location",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )))
                                : Container();
                  },
                ),

                // note provider of our screen responsible of refresh of teh note part
                BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    // if (state is NoteLoading) display lading state
                    //else if (state is NoteLoaded) display our notes
                    return state is Noteloading
                        ? Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          )
                        : state is NoteLoaded
                            ? Container(
                                height: MediaQuery.of(context).size.height / 2,
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: state.notes.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onLongPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AddNote(
                                                        edit_note:
                                                            state.notes[index],
                                                        index: index,
                                                      )));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          height: 120,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: const Color.fromARGB(
                                                    137, 221, 221, 221)),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "${state.notes[index].description}"),
                                                    Text(
                                                      "${state.notes[index].city_name}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ]),
                                              IconButton(
                                                  onPressed: () {
                                                    noteBloc.add(
                                                        PerformDeleteNote(
                                                            note: state
                                                                .notes[index]));
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .remove_circle_outline_sharp,
                                                    color: Color.fromARGB(
                                                        255, 255, 0, 0),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // button to go to add note page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => AddNote())));
        },
        backgroundColor: Color.fromARGB(255, 207, 154, 6),
        child: Icon(Icons.add),
      ),
    );
  }
}
