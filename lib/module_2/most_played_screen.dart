import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:music/main.dart';
import 'package:music/module_2/refactor/mostplaying_widget.dart';

class MostPlayedSong extends StatelessWidget {
  const MostPlayedSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: Text('Most Played Song'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 13.h),
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
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
                  return  SizedBox(
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
