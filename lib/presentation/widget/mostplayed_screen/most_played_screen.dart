import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/core/constant.dart';
import 'package:music/presentation/widget/mostplayed_screen/widget/mostplaying_widget.dart';

class MostPlayedSong extends StatelessWidget {
  const MostPlayedSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: const Text('Most Played Song'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13).r,
            child: ListView.separated(
                physics:const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return MostPlayed(
                    leadImage: mostPlayedSong[index]['leadImage'],
                    songName: mostPlayedSong[index]['songName'],
                    singerName: mostPlayedSong[index]['singerName'],
                    favour: index % 5 == 0 ? Colors.white : Colors.red,
                  );
                }),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: mostPlayedSong.length),
          ),
        ),
      ),
    );
  }
}
