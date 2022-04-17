import 'package:flutter/material.dart';

Widget splash({required String content}) {
  return Column(children: [
    const SizedBox(
      height: 350,
    ),
 const   Icon(
      Icons.music_video,
      size: 50,
      color: Colors.white,
    ),
  const  SizedBox(
      height: 30,
    ),
    Text(
      content,
      style:const TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'mono'),
    )
  ]);
}

