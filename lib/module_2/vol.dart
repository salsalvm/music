import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

dynamic count;

class PlayAudio extends StatefulWidget {
  final int index;
  PlayAudio({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends State<PlayAudio> {
  AudioPlayer audioPlayer = AudioPlayer();
  dynamic totalDuration = "00:00";
  dynamic position1 = "00:00";
  String? audioState;

  Duration duration = Duration();
  Duration position = Duration();
  bool playing = false;

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
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index < 10) {
      count = "00${widget.index}";
    } else if (widget.index < 100) {
      count = "0${widget.index}";
    } else {
      count = widget.index;
    }

    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PLAY AUDIO",
          style: TextStyle(fontFamily: "font4", fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          // Stack(
          //   children: [
          //     Container(
          //       height: _size.height * 0.50,
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //         image: AssetImage("assets/audioimg.jpg"),
          //       )),
          //       child: Padding(
          //         padding: const EdgeInsets.all(20),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(top: 60),
          //               child: Text(
          //                 'Surath ${quran.getSurahName(widget.index)}',
          //                 style: TextStyle(
          //                     fontSize: 40,
          //                     color: Color.fromARGB(255, 53, 7, 7),
          //                     fontFamily: "font6"),
          //               ),
          //             ),
          //             Text(
          //               'سورة ${quran.getSurahNameArabic(widget.index)}',
          //               style: TextStyle(
          //                   fontSize: 40,
          //                   color: Color.fromARGB(255, 53, 7, 7),
          //                   fontFamily: "font2"),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              slider(),
              ListTile(
                leading: Text(position.toString().split(".").first),
                trailing: Text(totalDuration.toString().split(".").first),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous_outlined,
                            size: 50,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          getAudio();
                        },
                        child: Icon(
                          playing == false
                              ? Icons.play_circle_fill_outlined
                              : Icons.pause_circle_filled_outlined,
                          size: 50,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.skip_next_outlined,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 0),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  size: 50,
                  color: Colors.red,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Add To Favourite",
              style: TextStyle(fontFamily: "font6", fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
      min: 0.0,
      value: position.inSeconds.toDouble(),
      max: duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          audioPlayer.seek(Duration(seconds: value.toInt()));
        });
      },
    );
  }

  void getAudio() async {
    var url = "https://server6.mp3quran.net/thubti/$count.mp3";
    if (playing) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        duration = dd;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        position = dd;
      });
    });
  }
}
