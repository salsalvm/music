import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_1/home.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_3/2-favourite_screen.dart';
import 'package:music/module_4/refactor/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatefulWidget {
  // final songId;
  MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final box=PlaylistBox.getInstance();

List<SongsModel>recent=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       recent= box.get("favourites")!.cast<SongsModel>();

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
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: (() async {
                      // log('message')
                        await OpenPlayer(fullSongs: [], index: index)
                            .openAssetPlayer(
                          index: index,
                          songs: fullSongs,
                        );
                        
                      }),
                      leading: QueryArtworkWidget(
                          artworkHeight: 60.h,
                          artworkWidth: 60.w,
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO),
                      title: Padding(
                        padding:
                             EdgeInsets.only(left: 5.0.w, bottom: 3.h, top: 3.h),
                        child: Text(
                          item.data![index].displayNameWOExt,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textWhite, fontSize: 18),
                        ),
                      ),
                      subtitle: Padding(
                        padding:  EdgeInsets.only(left: 7.0.w),
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
                  // return ListTile(
                },
                separatorBuilder: (context, index) {
                  return  SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: fullSongs.length)));
      },
    );
  }
}
