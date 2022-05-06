import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';

class UpdatePlaylist extends StatelessWidget {
  String playlistName;
  UpdatePlaylist({Key? key, required this.playlistName}) : super(key: key);
  final box = PlaylistBox.getInstance();
  String? title;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkBlue,
      title: Center(
          child: Text(
        'Edit Your Playlist Name',
        style: TextStyle(color: textWhite),
      )),
      // update
      content: Form(
        key: formKey,
        child: TextFormField(
          
          initialValue: playlistName,
          style: TextStyle(color: textWhite),
          onChanged: (value) {
            title = value.trim();
          },
          validator: (value) {
            final keys = box.keys.toList();
            if (value!.trim() == "") {
              return "Name Required";
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 5),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textWhite, width: 5)),
              fillColor: textWhite),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: textWhite, fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                    List?  curentPlaylistName=box.get(playlistName);
                    box.put(title, curentPlaylistName!);
                    box.delete(playlistName);
                    Navigator.pop(context);
                    }
                   },
                  child: Text(
                    'Update',
                    style: TextStyle(color: textWhite, fontSize: 18),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
