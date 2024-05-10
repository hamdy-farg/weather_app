import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/busseniss%20logic/bloc/weather_bloc.dart';
import 'package:wheather_app/busseniss%20logic/notes/bloc/note_bloc.dart';
import 'package:wheather_app/data/model/note.dart';
import 'package:wheather_app/data/model/wheather_model.dart';
import 'package:wheather_app/data/repo/get_notes.dart';
import 'package:wheather_app/presintation/widgets/text_form_field.dart';
import 'package:wheather_app/presintation/widgets/wide_button_widget.dart';

class AddNote extends StatelessWidget {
  Note? edit_note;
  int? index;
  AddNote({super.key, this.edit_note, this.index});
  // global form key of our form
  GlobalKey<FormState> form_key = GlobalKey();
  // description controller to save changes in the text from field
  TextEditingController description_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // weather provider
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    // the model we recieve the data on it
    WeatherModel weatherModel = (weatherBloc.state is WeatherLoaded)
        ? (weatherBloc.state as WeatherLoaded).weatherModel
        : WeatherModel(
            city_name: "turn on data", temp: 0, mainConditoin: "turn on data");
    // check if we want to edit or add note
    if (edit_note != null) {
      description_controller.text = edit_note!.description;
      weatherModel.city_name = edit_note!.city_name;
    }
    return Scaffold(
      // simple app bar and we can go back from it
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Add Note here",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      // bloc listener to navigat throw screen on changing of the state
      body: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteInitial) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "City Name is : ${weatherModel.city_name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),

              // to make virtical space between the widgets
              SizedBox(
                height: 20,
              ),

              // our form
              Form(
                  key: form_key,
                  child: TextFormFieldWidget(
                    hint_text: "Note Description",
                    max_line: 4,
                    text_edting_controller: description_controller,
                    validator: (Value) {
                      if (Value!.isEmpty) {
                        return ("field can not  be empty");
                      }
                    },
                  )),
              // custom button
              WidButton(
                color: Color.fromARGB(255, 207, 154, 6),
                splashColor: Color.fromARGB(255, 219, 196, 133),
                text: "Add Note",
                onTap: () {
                  if (form_key.currentState!.validate()) {
                    NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
                    if (edit_note == null || index == null) {
                      // to add PerformNote event to add new note
                      noteBloc.add(PerformNote(
                          city_name: weatherModel.city_name,
                          descriptoin: description_controller.text));
                    } else {
                      // to add performupdate event to update note
                      noteBloc.add(PerformUpdateNote(
                          index: index!,
                          note: Note(
                              city_name: weatherModel.city_name,
                              description: description_controller.text)));
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
