
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:music/main.dart';
import 'package:flutter/material.dart';
import 'package:music/module_1/mymusic_screen.dart';
import 'package:music/module_1/recent_screen.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:music/module_2/nowplaying_screen.dart';
import 'package:music/module_3/favourite_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music/module_1/refactor/home_widget.dart';
import 'package:music/module_3/search_items.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  bool _bool = true;
  bool pressed = false;
  

  @override
  void initState() {
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
            // brightness: Brightness.light,
            elevation: 0, backgroundColor: black,
           
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
              'beatzz',
              style: TextStyle(color: Colors.green),
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
                      padding:  EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 13).r,
                      child: MusicList(),
                    ),
                  ),

                  //  favourites
                   SingleChildScrollView(
                      child: SafeArea(
                          child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13).r,
                    child: FavouriteScreen(),
                  ))),

                  //  recent
                   SingleChildScrollView(
                      child: SafeArea(child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 13,horizontal: 15.0).r,
                        child: RecentSongs(),
                      ))),
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
                  artworkHeight: 60.h,
                  artworkWidth: 60.w,
                  id: int.parse(myAudio.metas.id!),
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(8).r,
                ),
                title: SizedBox(
                    height: 18.h,
                    child: Marquee(
                      text: myAudio.metas.title!,
                      style: TextStyle(color: textWhite),
                      velocity: 20,
                      startAfter: Duration.zero,
                      blankSpace: 100.w.h,
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
                      onPressed: playing.index == 0
                          ? () {
                              assetsAudioPlayer.id;
                            }
                          : () {},
                      icon: playing.index == 0
                          ?  Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.black45,
                              size: 43.sp,
                            )
                          : Icon(
                              Icons.skip_previous_rounded,
                              color: textWhite,
                              size: 43.sp,
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
                              size: 43.sp,
                            ),
                            onPressed: () {
                              assetsAudioPlayer.playOrPause();
                            },
                            color: textWhite,
                          );
                        }),

                    // next
                    IconButton(
                      iconSize: 45.sp,
                      onPressed: playing.index == fullSongs.length - 1
                          ? () {}
                          : () {
                              assetsAudioPlayer.next();
                            },
                      icon: playing.index == fullSongs.length - 1
                          ? Icon(
                              Icons.skip_next_rounded,
                              color: black,
                              size: 43.sp,
                            )
                          : Icon(
                              Icons.skip_next_rounded,
                              color: textWhite,
                              size: 43.sp,
                            ),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       assetsAudioPlayer.next();
                    //     },
                    //     icon: playing.index == fullSongs.length - 1
                    //         ? const Icon(
                    //             Icons.skip_next,
                    //             color: Colors.black38,
                    //             size: 43,
                    //           )
                    //         : Icon(
                    //             Icons.skip_next,
                    //             color: textWhite,
                    //             size: 43,
                    //           )),
                  ],
                ),
              ),
            );
          }),
        ));
  }

  void animationDrawer() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));

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
