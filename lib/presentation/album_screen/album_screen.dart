import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/album_screen/widget/album_song_screen.dart';
import 'package:music/presentation/artist_screen/artist_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumPage extends StatelessWidget {
   AlbumPage({Key? key}) : super(key: key);

  List<AlbumModel> allAlbums = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
        future: audioQuery.queryAlbums(),
        builder: (context, item) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: GridView.builder(
              itemCount: item.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  childAspectRatio: 4 / 4),
              itemBuilder: (context, index) {
                if (item.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (item.data!.isEmpty) {
                  return const Center(
                    child: Text('No Songs Found',
                        style: TextStyle(color: Colors.green)),
                  );
                }
                AlbumModel albumModel = item.data![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlbumDetailed(
                          albumId: albumModel.id,
                          albumName: albumModel.album,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 8.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: QueryArtworkWidget(
                              id: item.data![index].id,
                              type: ArtworkType.ALBUM,
                              artworkFit: BoxFit.cover,
                              artworkBorder: BorderRadius.circular(0),
                              quality: 100,
                              size: 400,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: textWhite,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF181717).withOpacity(.86),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    item.data![index].album,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(9, 5, 0, 0),
                                child: Text(
                                  item.data![index].artist.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
