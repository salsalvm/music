import 'package:flutter/material.dart';
import 'package:music/main.dart';

class UpdatePlaylist extends StatefulWidget {
  const UpdatePlaylist({Key? key}) : super(key: key);

  @override
  State<UpdatePlaylist> createState() => _UpdatePlaylistState();
}

class _UpdatePlaylistState extends State<UpdatePlaylist> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkBlue,
      title: Center(
          child: Text(
        'Edit Your Playlist Name',
        style: TextStyle(color: textWhite),
      )),
      content: TextFormField(
        
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
                  onPressed: () {},
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
