import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/main.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddSongBox extends StatefulWidget {
  String playListName;

  AddSongBox({Key? key, required this.playListName}) : super(key: key);

  @override
  State<AddSongBox> createState() => _AddSongBoxState();
}

class _AddSongBoxState extends State<AddSongBox> {
  List<Songs> playListsong = [];
  // List<Songs> dbSong = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    dbSongs = box.get("music") as List<Songs>;

    playListsong = box.get(widget.playListName)!.cast<Songs>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: ((context, value, child) {
          print(playListsong);
          playListsong = box.get(widget.playListName)!.cast<Songs>();
          return ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
                child: ListTile(
                    tileColor: boxColor,
                    leading: QueryArtworkWidget(
                      id: dbSongs[index].id!,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 55.h,
                      artworkWidth: 55.w,
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
                      child: Text(
                        dbSongs[index].songname!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textWhite, fontSize: 18.sp),
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(left: 7.0).r,
                      child: Text(
                        dbSongs[index].artist!.toLowerCase(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textGrey),
                      ),
                    ),
                    trailing: playListsong
                            .where((element) =>
                                element.id.toString() ==
                                dbSongs[index].id.toString())
                            .isEmpty
                        ? IconButton(
                            onPressed: () async {
                              playListsong.add(dbSongs[index]);
                              await box.put(widget.playListName, playListsong);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.playlist_add,
                              size: 35.sp,
                              color: Colors.green,
                            ))
                        : IconButton(
                            onPressed: () async {
                              setState(() {});
                              playListsong.removeWhere((element) =>
                                  element.id.toString() ==
                                  dbSongs[index].id.toString());
                              await box.put(widget.playListName, playListsong);
                            },
                            icon: Icon(Icons.playlist_add_check,
                                size: 35.sp, color: Colors.red))),
              );
            }),
            itemCount: dbSongs.length,
          );
        }));
  }
}
