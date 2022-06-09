import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/mymusic_screen/mymusic_screen.dart';
import 'package:music/presentation/recent_screen/recent_screen.dart';
import 'package:music/presentation/home/widget/miniplayer.dart';
import 'package:music/presentation/favourites_screen/favourite_screen.dart';
import 'package:music/presentation/home/widget/drawer.dart';
import 'package:music/presentation/search_screen/search_items.dart';

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        body: TabBarView(
          children: [
            //  musiclist
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13)
                        .r,
                child: MusicList(),
              ),
            ),

            //  favourites
            SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13).r,
              child: FavouriteScreen(),
            ))),

            //  recent
            SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 13, horizontal: 15.0).r,
              child: RecentSongs(),
            ))),
          ],
        ),

        // bottm tile
        bottomSheet: const MiniPlayer(),

        //drawer
        drawer: const Drawer(
          backgroundColor: black,
          child: StackItems(),
        ),
      ),
    );
  }
}
