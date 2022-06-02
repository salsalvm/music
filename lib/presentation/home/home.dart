import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/mymusic_screen/mymusic_screen.dart';
import 'package:music/presentation/recent_screen/recent_screen.dart';
import 'package:music/presentation/home/widget/miniplayer.dart';
import 'package:music/presentation/favourites_screen/favourite_screen.dart';
import 'package:music/presentation/home/widget/widget_home.dart';
import 'package:music/presentation/search_screen/search_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: lightBlue,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: black,
          leading: IconButton(
            icon: const Icon(Icons.menu),
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
            'beatz',
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
                    padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 13)
                        .r,
                    child: MusicList(),
                  ),
                ),

                //  favourites
                SingleChildScrollView(
                    child: SafeArea(
                        child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13)
                          .r,
                  child: FavouriteScreen(),
                ))),

                //  recent
                SingleChildScrollView(
                    child: SafeArea(
                        child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 15.0)
                          .r,
                  child: RecentSongs(),
                ))),
              ],
            ),

            // ALWAYS PLACE IT ON THE BOTTOM OF EVERY WIDGET...
            customNavigationDrawer(),
          ],
        ),

        // bottm tile
        bottomSheet: const MiniPlayer(),
      ),
    );
  }

  void animationDrawer() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

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

  Widget customNavigationDrawer() {
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
                child: const StackItems()),
          ),
        ),
      ),
    );
  }
}
