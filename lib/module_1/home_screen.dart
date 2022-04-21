import 'dart:ui';
import 'package:music/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:music/module_1/home_widget.dart';
import 'package:music/MAIN/widget.dart';

import 'package:music/module_3/search_items.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _audioQuery = new OnAudioQuery();

  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  bool _bool = true;

  @override
  void initState() {
    requestPermision();
    super.initState();

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

  void requestPermision() {
    Permission.storage.request();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              icon: Icon(Icons.menu_rounded),
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
                  icon: Icon(EvaIcons.heart),
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
              'Home',
            ),
            centerTitle: true,
          ),
          body: Stack(children: [
            TabBarView(children: [
              SingleChildScrollView(
                child: SafeArea(
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
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Container(
                                margin: const EdgeInsets.all(0.0),
                                padding: const EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                    color: boxtColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: ListTile(
                                    onTap: () {},
                                    leading: QueryArtworkWidget(
                                        id: item.data![index].id,
                                        type: ArtworkType.AUDIO),
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, bottom: 3, top: 3),
                                      child: Text(
                                        item.data![index].displayNameWOExt,
                                        style: TextStyle(
                                            color: textWhite, fontSize: 18),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "${item.data![index].artist}",
                                        style: TextStyle(color: textGrey),
                                      ),
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              EvaIcons.heart,
                                              size: 22,
                                              color: index % 4 == 0
                                                  ? Colors.white
                                                  : Colors.red[800],
                                            )),
                                        popupMenuHoriz(context)
                                      ],
                                    )),
                              );
                              // return ListTile(
                            }),
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: item.data!.length);
                      }),
                )),
              ),
              SingleChildScrollView(
                child: SafeArea(child: Text('fAVOURITES')),
              ),
              SingleChildScrollView(child: SafeArea(child: Text('RECENT'))),
            ]),

            // ALWAYS PLACE IT ON THE BOTTOM OF EVERY WIDGET...
            CustomNavigationDrawer(),
          ]),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: lightBlue,
            elevation: 50,
            child: Container(
              child: bottomNavigation(
                context,
              ),
            ),
          ),
        ));
  }

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
                child: stackItems(context)),
          ),
        ),
      ),
    );
  }
}
