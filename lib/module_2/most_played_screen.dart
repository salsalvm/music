import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_2/mostplaying_widget.dart';

class MostPlayedSong extends StatelessWidget {
  const MostPlayedSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: lightBlue,
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
       child:SingleChildScrollView(physics: BouncingScrollPhysics(),child: mostPlayed(context))
      ),
    );
  }
}
