import 'package:flutter/material.dart';
import 'package:music/main.dart';

class PlayListItem extends StatelessWidget {
  final onTap;
  final playListName;
  final countSong;
  const PlayListItem(
      {Key? key,
      required this.onTap,
      required this.countSong,
      required this.playListName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: boxtColor, borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            onTap: onTap,
            leading: Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 5),
              child: Icon(
                Icons.queue_music_rounded,
                color: textWhite,
                size: 30,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 3.0, bottom: 3, top: 5),
              child: Text(
                playListName,
                style: TextStyle(color: textWhite, fontSize: 18),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Text(
                countSong,
                style: TextStyle(
                  color: textGrey,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

// form field

class CreatePlaylistShowAlert extends StatefulWidget {
   CreatePlaylistShowAlert({Key? key}) : super(key: key);

  @override
  State<CreatePlaylistShowAlert> createState() => _CreatePlaylistShowAlertState();
}

class _CreatePlaylistShowAlertState extends State<CreatePlaylistShowAlert> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: darkBlue,
      alignment: Alignment.center,
      title: Center(
          child: Text(
        "Give Your Playlist Name",
        style: TextStyle(color: textWhite),
      )),
      content: Form(
        key: formKey,
        child: TextFormField(
            // onChanged: ((value) => title=value.trim()),
            style: TextStyle(color: textWhite),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textWhite, width: 5)),
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
              TextButton(
                child: Text("Create",
                    style: TextStyle(color: textWhite, fontSize: 16)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: boxtColor,
                      margin: EdgeInsets.all(10),
                      content: Text('Playlist Added ')));
                  Navigator.pop(context);
                  setState(() {
                    
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
