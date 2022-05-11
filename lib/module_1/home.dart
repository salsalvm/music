import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:marquee/marquee.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:flutter/material.dart';
import 'package:music/module_1/music_screen.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/favourite_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music/module_1/refactor/home_widget.dart';
import 'package:music/module_3/search_items.dart';
import 'dart:developer' as devlog;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<SongModel> fetchedSongs = [];
List<SongModel> allSongs = [];
List<SongsModel> mappedSongs = [];
List<SongsModel> dbSongs = [];
List<Audio> fullSongs = [];
final box = PlaylistBox.getInstance();

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  bool _bool = true;
  bool pressed = false;
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    requestStoragePermissiono();
    super.initState();
    animationDrawer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: lightBlue,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            brightness: Brightness.light,
            elevation: 0, backgroundColor: lightBlue,
            // backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.menu),
              splashColor: Colors.transparent,
              onPressed: () {
                if (_bool == true) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                _bool = false;
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: MySearch());
                  },
                  icon: const Icon(Icons.search))
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: 'favorites',
                ),
                Tab(
                  icon: Icon(Icons.restore),
                  text: 'Recent',
                ),
              ],
              labelColor: Colors.white,
            ),
            title: const Text(
              'beatzz',style: TextStyle(color: Colors.green),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  //  musiclist
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 13),
                      child: FutureBuilder<List<SongModel>>(
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
                          return MusicList();
                        },
                      ),
                    ),
                  ),

                  //  favourites
                 const SingleChildScrollView(child: SafeArea(child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                   child: FavouriteScreen(),
                 ))),

                  //  recent
                const SingleChildScrollView(child: SafeArea(child: Text('RECENT'))),
                ],
              ),

              // ALWAYS PLACE IT ON THE BOTTOM OF EVERY WIDGET...
              CustomNavigationDrawer(),
            ],
          ),

          // bottm tile
          bottomSheet: assetsAudioPlayer.builderCurrent(
              builder: (BuildContext context, Playing? playing) {
            final myAudio = find(fullSongs, playing!.audio.assetAudioPath);
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NowPlaying(
                                songId: int.parse(myAudio.metas.id!).toString(),
                                allSongs: fullSongs,
                                index: 0,
                              )));
                },
                tileColor: boxColor,
                leading: QueryArtworkWidget(
                  artworkHeight: 60,
                  artworkWidth: 60,
                  id: int.parse(myAudio.metas.id!),
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(8),
                ),
                title: SizedBox(
                    height: 18,
                    child: Marquee(
                      text: myAudio.metas.title!,
                      style: TextStyle(color: textWhite),
                      velocity: 20,
                      startAfter: Duration.zero,
                      blankSpace: 100,
                    )),
                subtitle: Text(
                  myAudio.metas.artist!.toLowerCase(),
                  style: TextStyle(color: textGrey),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    //  previous
                    IconButton(
                      onPressed: () {
                        assetsAudioPlayer.previous();
                      },
                      icon: playing.index == 0
                          ? const Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.black45,
                              size: 43,
                            )
                          : Icon(
                              Icons.skip_previous_rounded,
                              color: textWhite,
                              size: 43,
                            ),
                    ),
                    // play pause
                    PlayerBuilder.isPlaying(
                        player: assetsAudioPlayer,
                        builder: (context, isPlaying) {
                          return IconButton(
                            icon: Icon(
                              isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: 43,
                            ),
                            onPressed: () {
                              assetsAudioPlayer.playOrPause();
                            },
                            color: textWhite,
                          );
                        }),

                    // next

                    IconButton(
                        onPressed: () {
                          assetsAudioPlayer.next();
                        },
                        icon: playing.index == fullSongs.length - 1
                            ? const Icon(
                                Icons.skip_next,
                                color: Colors.black38,
                                size: 43,
                              )
                            : Icon(
                                Icons.skip_next,
                                color: textWhite,
                                size: 43,
                              )),
                  ],
                ),
              ),
            );
          }),
        ));
  }

  requestStoragePermissiono() async {
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      _audioQuery.permissionsRequest();
    }
    setState(() {});

    // allmedia fetched from storage
    fetchedSongs = await _audioQuery.querySongs();
    for (var element in fetchedSongs) {
      if (element.fileExtension == "mp3") {
        allSongs.add(element);
      }
    }

    mappedSongs = allSongs
        .map((audio) => SongsModel(
            id: audio.id,
            artist: audio.artist,
            duration: audio.duration,
            songname: audio.title,
            songurl: audio.uri))
        .toList();

    await box.put("music", mappedSongs);
    dbSongs = box.get("music") as List<SongsModel>;

// seperat song details
    for (var element in dbSongs) {
      fullSongs.add(
        Audio.file(
          element.songurl.toString(),
          metas: Metas(
            title: element.songname,
            id: element.id.toString(),
            artist: element.artist,
          ),
        ),
      );
    }
    setState(() {});
  }

  void animationDrawer() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _animation1 = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _bool = true;
        }
      });
    _animation2 = Tween<double>(begin: 0, end: .3).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animation3 = Tween<double>(begin: .9, end: 1).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
  }

  // menu bar

  Widget CustomNavigationDrawer() {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaY: _animation1.value, sigmaX: _animation1.value),
      child: Container(
        height: _bool ? 0 : _height,
        width: _bool ? 0 : _width,
        color: Colors.transparent,
        child: Center(
          child: Transform.scale(
            scale: _animation3.value,
            child: Container(
                width: _width * .9,
                height: _width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_animation2.value),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: StackItems()),
          ),
        ),
      ),
    );
  }
}