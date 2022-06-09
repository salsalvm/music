import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/application/block/playlist/playlist_bloc.dart';
import 'package:music/core/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddSongBox extends StatelessWidget {
  String playListName;

  AddSongBox({Key? key, required this.playListName}) : super(key: key);

  List<Songs> playListsong = [];



  @override
  Widget build(BuildContext context) {
    playListsong = box.get(playListName)!.cast<Songs>();
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: ((context, value, child) {
          playListsong = box.get(playListName)!.cast<Songs>();
          return ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
                child: ListTile(
                    tileColor: boxColor,
                    leading: QueryArtworkWidget(
                      id: dbSongs[index].id!,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 55.h,
                      artworkWidth: 55.w,
                    ),
                    title: Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
                      child: Text(
                        dbSongs[index].songname!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textWhite, fontSize: 18.sp),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 7.0).r,
                      child: Text(
                        dbSongs[index].artist!.toLowerCase(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: textGrey),
                      ),
                    ),
                    trailing:
                        BlocBuilder<PlaylistBloc, PlaylistState>(
                      builder: (context, state) {
                        return playListsong
                                .where((element) =>
                                    element.id.toString() ==
                                    dbSongs[index].id.toString())
                                .isEmpty
                            ? IconButton(
                                onPressed: () async {
                                  playListsong.add(dbSongs[index]);
                                  await box.put(
                                      playListName, playListsong);
                                  context
                                      .read<PlaylistBloc>()
                                      .add(PlaylistIconPress(icon: Icons.add));
                                },
                                icon: Icon(
                                  Icons.playlist_add,
                                  size: 35.sp,
                                  color: Colors.green,
                                ))
                            : IconButton(
                                onPressed: () async {
                                  playListsong.removeWhere((element) =>
                                      element.id.toString() ==
                                      dbSongs[index].id.toString());
                                  await box.put(
                                      playListName, playListsong);
                                  context.read<PlaylistBloc>().add(
                                      PlaylistIconPress(
                                          icon: Icons.playlist_add_check));
                                },
                                icon: Icon(Icons.playlist_add_check,
                                    size: 35.sp, color: Colors.red),
                              );
                      },
                    )),
              );
            }),
            itemCount: dbSongs.length,
          );
        }));
  }
}
