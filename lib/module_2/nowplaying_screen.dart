import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_2/nowPlaying_Transperant.dart';
import 'package:music/module_2/nowplaying_widget.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Now Playing',
            style: TextStyle(),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: NowPlayingDesigns(),
          ),
        ));
  }
}
