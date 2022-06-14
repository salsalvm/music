import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/album_screen/widget/album_song_screen.dart';
import 'package:music/presentation/artist_screen/widget/artist_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
final OnAudioQuery audioQuery = OnAudioQuery();

class ArtistLists extends StatefulWidget {
  const ArtistLists({Key? key}) : super(key: key);

  @override
  State<ArtistLists> createState() => _ArtistListsState();
}

List<ArtistModel> allArtists = [];

class _ArtistListsState extends State<ArtistLists> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArtistModel>>(
      future: audioQuery.queryArtists(),
      builder: (context, item) {
        return GridView.builder(
          itemCount: item.data!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 19 / 25),
          itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.ARTIST,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            color: Colors.grey[850]),
                        child: GestureDetector(   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlbumDetailed(
                          albumId: item.data![index].id,
                          albumName: item.data![index].artist,
                        ),
                      ),
                    );
                  }, 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                child: Text(
                                  item.data![index].artist,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 4, 0, 0),
                                child: Text(
                                  item.data![index].numberOfTracks.toString() +
                                      ' SONGS',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
