import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';

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
            child: ClipRRect(borderRadius: BorderRadius.circular(15),
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
Widget smallwidth =SizedBox(width: 30,);


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

Widget playButton(){return Row(mainAxisAlignment: MainAxisAlignment.center,
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
            ),smallwidth,
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
            ),smallwidth,
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
        );}


  