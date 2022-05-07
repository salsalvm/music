import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music/main.dart';
import 'package:music/module_1/home_screen.dart';
import 'package:music/module_1/open_palyer.dart';
import 'package:music/module_2/nowplaying_screen.dart';
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
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      
      hintColor: textWhite,
      appBarTheme: AppBarTheme(
        color: black,
        // titleTextStyle: TextInputType.text.,
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
        icon: Icon(
          Icons.arrow_back,
          color: textWhite,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,style: TextStyle(color: textWhite),
      ),
    );
  }

// search element
  @override
  Widget buildSuggestions(BuildContext context) {
    final searchSongItems = query.isEmpty
        ? fullSongs
        : fullSongs
                .where((element) => element.metas.title!
                    .toLowerCase()
                    .startsWith(query.toLowerCase().toString()))
                .toList() +
            fullSongs
                .where((element) => element.metas.artist!
                    .toLowerCase()
                    .startsWith(query.toLowerCase().toString()))
                .toList();

    return Scaffold(
      backgroundColor: black,
      body: searchSongItems.isEmpty
          ? const Center(
              child: Text(
              "No Data Found!",
              style: TextStyle(color: Colors.green),
            ))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: (() async {
                          await OpenPlayer(fullSongs: [], index: index)
                              .openAssetPlayer(index: index, songs: fullSongs);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => NowPlaying(
                                      allSongs: fullSongs,
                                      index: 0,
                                      songId: int.parse(
                                              searchSongItems[index].metas.id!)
                                          .toString()))));
                        }),
                        leading: QueryArtworkWidget(
                            artworkHeight: 60,
                            artworkWidth: 60,
                            id: int.parse(searchSongItems[index].metas.id!),
                            type: ArtworkType.AUDIO),
                        title: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, bottom: 3, top: 3),
                          child: Text(
                            searchSongItems[index].metas.title!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textWhite, fontSize: 18),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: Text(
                            searchSongItems[index].metas.artist!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textGrey),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_arrow,
                              size: 25,
                              color: textWhite,
                            )),
                      ),
                    );
                    // return ListTile(
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: searchSongItems.length),
            ),
    );
  }
}
