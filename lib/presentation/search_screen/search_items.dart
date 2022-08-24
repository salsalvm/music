import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/nowplaying_screen/nowplaying_screen.dart';
import 'package:music/presentation/widget/open_palyer.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          color: textGrey,
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(
            Icons.clear,
          ))
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: const TextTheme(displayMedium: TextStyle(color: textWhite)),
      hintColor: textWhite,
      appBarTheme: const AppBarTheme(
        color: black,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: textWhite,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(color: textWhite),
      ),
    );
  }

// search element
  @override
  Widget buildSuggestions(BuildContext context) {
    final searched = fullSongs
        .toList()
        .where((element) =>
            element.metas.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: black,
      body: searched.isEmpty
          ? const Center(
              child: Text(
              "No Songs Found!",
              style: TextStyle(color: Colors.green),
            ))
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15).r,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(15).r),
                      child: ListTile(
                        onTap: (() async {
                          Navigator.pop(context);
                          await OpenPlayer(
                            fullSongs: searched,
                            index: index,
                            songId: int.parse(
                              searched[index].metas.id!,
                            ).toString(),
                          ).openAssetPlayer(
                            index: index,
                            songs: searched,
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => NowPlaying(
                          //             allSongs: fullSongs,
                          //             index: 0,
                          //             songId: int.parse(fullSongs[index]
                          //                     .metas
                          //                     .id
                          //                     .toString())
                          //                 .toString()))));
                        }),
                        leading:
                            // Image.network('https://cdn.britannica.com/84/73184-004-E5A450B5/Sunflower-field-Fargo-North-Dakota.jpg'),
                            QueryArtworkWidget(
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
                                id: int.parse(
                                    searched[index].metas.id.toString()),
                                type: ArtworkType.AUDIO),
                        title: Padding(
                          padding: const EdgeInsets.only(
                                  left: 5.0, bottom: 3, top: 3)
                              .r,
                          child: Text(
                            searched[index].metas.title!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textWhite, fontSize: 18.sp),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 7.0).r,
                          child: Text(
                            fullSongs[index].metas.artist!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: textGrey),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_arrow,
                              size: 25.sp,
                              color: textWhite,
                            )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: searched.length),
            ),
    );
  }
}
