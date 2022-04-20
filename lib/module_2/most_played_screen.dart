import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_2/mostplaying_widget.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
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
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: mostPlayedSong.length),
          ),
        ),
      ),
    );
  }
}
