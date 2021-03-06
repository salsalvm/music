import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/favourites_screen/widget/favourite_icon_add.dart';
import 'package:music/presentation/widget/open_palyer.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:music/presentation/widget/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatelessWidget {
  MusicList({Key? key}) : super(key: key);

  List<Songs> recent = [];

  @override
  Widget build(BuildContext context) {
    recent = box.get("favourites")!.cast<Songs>();
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
            child: CircularProgressIndicator(),
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
                      leading: QueryArtworkWidget(
                          artworkHeight: 60.h,
                          artworkWidth: 60.w,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: textWhite,
                            size: 30,
                          ),
                          artworkQuality: FilterQuality.high,
                          size: 2000,
                          quality: 100,
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO),
                      title: Padding(
                        padding:
                            const EdgeInsets.only(left: 5.0, bottom: 3, top: 3)
                                .r,
                        child: Text(
                          item.data![index].displayNameWOExt,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textWhite, fontSize: 18.sp),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 7.0).r,
                        child: Text(
                          "${item.data![index].artist}".toLowerCase(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: textGrey),
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
                itemCount: dbSongs.length)));
      },
    );
  }
}
