import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_2/volume_slider.dart';

class NowPlayingDesigns extends StatefulWidget {
  const NowPlayingDesigns({Key? key}) : super(key: key);

  @override
  State<NowPlayingDesigns> createState() => _NowPlayingDesignsState();
}

class _NowPlayingDesignsState extends State<NowPlayingDesigns> {
  //  AudioPlayer audioPlayer = AudioPlayer();
  dynamic totalDuration = "00:00";
  Duration position = Duration();
  // dynamic position1 = "00:00";
  // String? audioState;
  // Duration duration = Duration();
  int _value = 6;
  //  initAudio() {
  //   audioPlayer.onDurationChanged.listen((updatedDuration) {
  //     setState(() {
  //       totalDuration = updatedDuration;
  //     });
  //   });
  //   audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
  //     setState(() {
  //       position = updatedPosition;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          bigBlankSpace,
          Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 280,
        width: 350,
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
      bigBlankSpace,
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: listtiles(),
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  position.toString().split(".").first,
                  style: TextStyle(color: textWhite),
                ),
                Text(totalDuration.toString().split(".").first,
                    style: TextStyle(color: textWhite)),
              ],
            ),
          ),
        SizedBox(
  height: 25,
),
          addAndVol(),
          playButton()
        ],
      )),
    );
  }
}

Widget bigBlankSpace = SizedBox(
  height: 80,
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
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              EvaIcons.shuffle2,
              color: textWhite,
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
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
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
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          child: MyVolumeUp()
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.volume_up,
          //       color: textWhite,
          //       size: 30,
          //     )),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                size: 30,
                color: textWhite,
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
            color: Colors.transparent, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.skip_previous_rounded,
              color: textWhite,
              size: 40,
            )),
      ),
      smallwidth,
      Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.play_arrow_rounded,
              color: textWhite,
              size: 40,
            )),
      ),
      smallwidth,
      Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(50)),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.skip_next_rounded,
              color: textWhite,
              size: 40,
            )),
      ),
    ],
  );
}
