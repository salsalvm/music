import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/core/constant.dart';
import 'package:music/domain/songmodel.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddSongFavourites extends StatefulWidget {
  const AddSongFavourites({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSongFavourites> createState() => _AddSongFavouritesState();
}

class _AddSongFavouritesState extends State<AddSongFavourites> {
  final box = StorageBox.getInstance();
  List<Songs> favSongs = [];

  @override
  void initState() {
    super.initState();
    favSongs = box.get("favourites")!.cast<Songs>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: ((context, value, child) {
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
                    trailing: favSongs
                            .where((element) =>
                                element.id.toString() ==
                                dbSongs[index].id.toString())
                            .isEmpty
                        ? StatefulBuilder(builder: (context, setState) {
                            return IconButton(
                                onPressed: () {
                                  favSongs.add(dbSongs[index]);
                                  box.put("favourites", favSongs);

                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: boxColor,
                                          margin: const EdgeInsets.all(10).r,
                                          content: Text(
                                              '${dbSongs[index].songname} Song Removed ')));
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: 35.sp,
                                  color: Colors.white,
                                ));
                          })
                        : IconButton(
                            onPressed: () {
                              favSongs.removeWhere((element) =>
                                  element.id.toString() ==
                                  dbSongs[index].id.toString());
                              box.put("favourites", favSongs);
                              setState(() {});
                            },
                            icon: Icon(Icons.favorite,
                                size: 35.sp, color: Colors.red))),
              );
            }),
            itemCount: dbSongs.length,
          );
        }));
  }
}
