import 'package:flutter/material.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:on_audio_query/on_audio_query.dart';

// create play list

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
      backgroundColor: darkBlue,
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

// get playlist

class PlayListItem extends StatelessWidget {
  // final onTap;
  SongsModel song;
  List playlists = [];
  List<dynamic>? playlistSongs = [];

  // final playListName;
  final countSong;
  PlayListItem(
      {Key? key,
      // required this.onTap,
      required this.countSong,
      required this.song})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = PlaylistBox.getInstance();
    playlists = box.keys.toList();

    return Column(
      children: [
        ...playlists
            .map(
              (audio) => audio != "music"
                  ? Container(
                      decoration: BoxDecoration(
                          color: boxtColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () async {
                          playlistSongs = box.get(audio);
                          List existingSongs = [];
                          existingSongs = playlistSongs!
                              .where((element) =>
                                  element.id.toString() == song.id.toString())
                              .toList();
                          if (existingSongs.isEmpty) {
                            final songs = box.get("music") as List<SongsModel>;
                            final temp = songs.firstWhere((element) =>
                                element.id.toString() == song.id.toString());
                            playlistSongs?.add(temp);
                            await box.put(audio, playlistSongs!);

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  song.songname! + 'Added to Playlist',style: TextStyle(color: textWhite),
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(song.songname! +
                                    'is Already in Playlist.',style: TextStyle(color: textWhite),)));
                          }
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 6.0, top: 5),
                          child: Icon(
                            Icons.queue_music_rounded,
                            color: textWhite,
                            size: 30,
                          ),
                        ),

                        // playlist name
                        title: Padding(
                          padding: const EdgeInsets.only(
                              left: 3.0, bottom: 3, top: 5),
                          child: Text(
                            audio.toString(),
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
                    )
                  : Container(),
            )
            .toList()
      ],
    );
  }
}
