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
      Container(
        color: black,
        child: IconButton(
            color: textWhite,
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(
              Icons.clear,
            )),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container(
      color: black,
      child: IconButton(
          onPressed: () {
            close(context, null);
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: darkBlue,
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchSongItems = query.isEmpty
        ? fullSongs
        : fullSongs
            .where((element) => element.metas.title!
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList()+fullSongs
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
                              .openAssetPlayer(
                            index: index,
                            songs: fullSongs,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NowPlaying(
                                        songId: int.parse(searchSongItems[index]
                                                .metas
                                                .id!)
                                            .toString(),
                                        allSongs: fullSongs,
                                        index: 0,
                                      )));
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
