
import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CreatePlaylistForm extends StatefulWidget {
  CreatePlaylistForm({Key? key}) : super(key: key);

  @override
  State<CreatePlaylistForm> createState() => _CreatePlaylistFormState();
}

class _CreatePlaylistFormState extends State<CreatePlaylistForm> {
  @override
  Widget build(BuildContext context) {
    List<PlaylistModel> playlist = [];
    final box = PlaylistBox.getInstance();
    String? title;
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      backgroundColor: boxColor,
      alignment: Alignment.center,
      title: Center(
          child: Text(
        "Give Your Playlist Name",
        style: TextStyle(color: textWhite),
      )),

      // form validation
      content: Form(
        key: formKey,
        child: TextFormField(
            onChanged: (value) {
              title = value.trim();
            },
            validator: (value) {
              List keys = box.keys.toList();
              if (value!.trim() == "") {
                return "Name Required";
              }
              if (keys.where((element) => element == value.trim()).isNotEmpty) {
                return "This Name Already Exist";
              }
              return null;
            },
            style: TextStyle(color: textWhite),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: darkBlue, width: 5)),
              fillColor: textWhite,
              hintText: 'Playlist Name',
              hintStyle: TextStyle(color: textGrey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textGrey, width: 5.0),
              ),
            )),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text("Cancel",
                    style: TextStyle(color: textWhite, fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              // add playlist from db
              TextButton(
                child: Text("Create",
                    style: TextStyle(color: textWhite, fontSize: 16)),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    box.put(title, playlist);
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}