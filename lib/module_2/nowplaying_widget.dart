import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_2/nowPlaying_Transperant.dart';
import 'package:music/module_4/playlist_widget.dart';

class NowPlayingDesign extends StatefulWidget {
  const NowPlayingDesign({Key? key}) : super(key: key);

  @override
  State<NowPlayingDesign> createState() => _NowPlayingDesignState();
}

class _NowPlayingDesignState extends State<NowPlayingDesign> {
  AudioPlayer audioPlayer = AudioPlayer();
  dynamic totalDuration = "00:00";
  dynamic position1 = "00:00";
  String? audioState;
  Duration duration = Duration();
  Duration position = Duration();
  int _value = 6;

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      setState(() {
        totalDuration = updatedDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      setState(() {
        position = updatedPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        bigBlankSpace,
        Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: darkBlue),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 270,
            width: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: AssetImage(
                  'lib/assets/bheeshma.jpeg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        smallBlankSpace,
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: listtiles(),
        ),
        // smallBlankSpace,
        Slider(
            value: _value.toDouble(),
            min: 1.0,
            max: 20.0,
            divisions: 10,
            activeColor: textWhite,
            inactiveColor: textGrey,
            // label: '',
            onChanged: (double newValue) {
              setState(() {
                _value = newValue.round();
              });
            },
            semanticFormatterCallback: (double newValue) {
              return '${newValue.round()} dollars';
            }),
        // bigBlankSpace,
        // slider(),
        ListTile(
          leading: Text(position.toString().split(".").first),
          trailing: Text(totalDuration.toString().split(".").first),
        ),
        addAndVol(),
        // smallBlankSpace,
        playButton()
      ],
    ));
  }
  // Widget slider() {
  //   return Slider.adaptive(
  //     min: 0.0,
  //     value: position.inSeconds.toDouble(),
  //     max: duration.inSeconds.toDouble(),
  //     onChanged: (double value) {
  //       setState(() {
  //         audioPlayer.seek(Duration(seconds: value.toInt()));
  //       });
  //     },
  //   );
  // }

}

Widget bigBlankSpace = SizedBox(
  height: 60,
);
Widget smallBlankSpace = SizedBox(
  height: 25,
);
Widget smallwidth = SizedBox(
  width: 30,
);

// row

Widget listtiles() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: textWhite, borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              EvaIcons.shuffle2,
              color: darkBlue,
              size: 30,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Parudheesa',
              style: TextStyle(fontSize: 22, color: textWhite),
            ),
            Text(
              'sree nadh bhaasi',
              style: TextStyle(color: textGrey, fontSize: 14),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: textWhite, borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              EvaIcons.heart,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
      ],
    ),
  );
}

// vol and add

Widget addAndVol() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: textWhite, borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.volume_up,
                color: darkBlue,
                size: 30,
              )),
        ),
        Container(
          decoration: BoxDecoration(
              color: textWhite, borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                size: 30,
                color: darkBlue,
              )),
        )
      ],
    ),
  );
}

Widget playButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
            color: textWhite, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.skip_previous_rounded,
              color: darkBlue,
              size: 30,
            )),
      ),
      smallwidth,
      Container(
        decoration: BoxDecoration(
            color: textWhite, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.play_arrow_rounded,
              color: darkBlue,
              size: 30,
            )),
      ),
      smallwidth,
      Container(
        decoration: BoxDecoration(
            color: textWhite, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.skip_next_rounded,
              color: darkBlue,
              size: 30,
            )),
      ),
    ],
  );
}

Widget playListBotttom(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Stack(
      children: [
        
        ListView(
          children: [
            bottomPlaylist(
              playListName: 'Ever green',
              countSong: '5 song',
              onTap: () {},
            ),
            bottomPlaylist(
              playListName: 'English Song',
              countSong: ' song',
            ),
            bottomPlaylist(playListName: 'Hindi Song', countSong: '2 song'),
            bottomPlaylist(
              playListName: 'Ever green',
              countSong: '5 song',
              onTap: () {},
            ),
            bottomPlaylist(
              playListName: 'English Song',
              countSong: ' song',
            ),
            bottomPlaylist(playListName: 'Hindi Song', countSong: '2 song'),
            // PlayList(playListName: 'Sithara', countSong: '2 song'),
            // PlayList(playListName: 'Arjith sing', countSong: '2 song'),
          ],
          
        ),
        Container(alignment: Alignment.topRight,padding: EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.minimize_outlined,
                color: textWhite,
                size: 40,
              )),
        ),
        Container(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                createPlaylistShowAlertDialog(context);
              },
              backgroundColor: darkBlue,
              child: Icon(Icons.add),
            )),
      ],
    ),
  );
}

Widget bottomPlaylist({onTap, required playListName, required countSong}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            color: boxtColor, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          onTap: onTap,
          leading: Padding(
            padding: const EdgeInsets.only(left: 6.0, top: 5),
            child: Icon(
              Icons.queue_music_rounded,
              color: textWhite,
              size: 30,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 3.0, bottom: 3, top: 5),
            child: Text(
              playListName,
              style: TextStyle(color: textWhite, fontSize: 18),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text(
              countSong,
              style: TextStyle(
                color: textGrey,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
