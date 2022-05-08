import 'package:flutter/material.dart';
import 'package:music/main.dart';
import 'package:music/module_1/home.dart';
import 'package:music/module_1/refactor/open_palyer.dart';
import 'package:music/module_4/refactor/menu_popup_horiz.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatelessWidget {
  const MusicList({ Key? key }) : super(key: key);

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
                          return ListView.separated(
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
                                      await OpenPlayer(
                                              fullSongs: [], index: index)
                                          .openAssetPlayer(
                                        index: index,
                                        songs: fullSongs,
                                      );
                                    }),
                                    leading: QueryArtworkWidget(
                                        artworkHeight: 60,
                                        artworkWidth: 60,
                                        id: item.data![index].id,
                                        type: ArtworkType.AUDIO),
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, bottom: 3, top: 3),
                                      child: Text(
                                        item.data![index].displayNameWOExt,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: textWhite, fontSize: 18),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 7.0),
                                      child: Text(
                                        "${item.data![index].artist}"
                                            .toLowerCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: textGrey),
                                      ),
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.favorite,
                                              size: 22,
                                              color: index % 4 == 0
                                                  ? Colors.white
                                                  : Colors.red[800],
                                            )),
                                        MenuHoriz(
                                            songId: fullSongs[index]
                                                .metas
                                                .id
                                                .toString())
                                      ],
                                    ),
                                  ),
                                );
                                // return ListTile(
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: fullSongs.length);
                        },
                      );
  }
}