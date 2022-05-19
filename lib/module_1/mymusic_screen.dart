import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_1/home.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:music/module_3/favourite_screen.dart';
import 'package:music/module_4/refactor/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatefulWidget {
  MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final box = StorageBox.getInstance();

  List<Songs> recent = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recent = box.get("favourites")!.cast<Songs>();
  }

  // List<Audio> fav = [];
  @override
  Widget build(BuildContext context) {
    final OnAudioQuery _audioQuery = OnAudioQuery();
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
              child: Text(
            'no songs found',
            style: TextStyle(color: Colors.teal),
          ));
        }
        return ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: ((context, value, child) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(15).r),
                    child: ListTile(
                      onTap: (() async {
                        await OpenPlayer(
                                fullSongs: [],
                                index: index,
                                songId: fullSongs[index].metas.id.toString())
                            .openAssetPlayer(
                          index: index,
                          songs: fullSongs,
                        );
                      }),
                      leading:
                           QueryArtworkWidget(
                              artworkHeight: 60.h,
                              artworkWidth: 60.w,
                              nullArtworkWidget: Icon(Icons.music_note,color: textWhite,size: 30,),
                              artworkQuality: FilterQuality.high,
                              size: 2000,quality: 100,
                              id: item.data![index].id,
                              type: ArtworkType.AUDIO),
                      title: Padding(
                        padding:
                            EdgeInsets.only(left: 5.0, bottom: 3, top: 3).r,
                        child: Text(
                          item.data![index].displayNameWOExt,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textWhite, fontSize: 18.sp),
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(left: 7.0).r,
                        child: Text(
                          "${item.data![index].artist}".toLowerCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textGrey),
                        ),
                      ),
                      trailing: Wrap(
                        children: [
                          FavouriteIcon(
                            songId: fullSongs[index].metas.id.toString(),
                          ),
                          MenuHoriz(
                              songId: fullSongs[index].metas.id.toString())
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: fullSongs.length)));
      },
    );
  }
}
