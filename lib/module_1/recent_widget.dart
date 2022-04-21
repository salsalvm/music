// import 'package:flutter/material.dart';
// import 'package:music/module_1/home_widget.dart';

// List<Map<String, dynamic>> recentSong = [
//   {
//     "leadImage": "lib/assets/bheeshma.jpeg",
//     "songName": "Parudheesa",
//     "singerName": "sree nadh bhasi",
//   },
//   {
//     "leadImage": "lib/assets/agarthum.webp",
//     "songName": "Agar thum saath",
//     "singerName": "arjith sing",
//   },
//   {
//     "leadImage": "lib/assets/pal.webp",
//     "songName": "Pal",
//     "singerName": "arjith sing",
//   },
//   {
//     "leadImage": "lib/assets/uyire.webp",
//     "songName": "Uyire",
//     "singerName": "narayani",
//   }
// ];


// // recent

// Widget recentListView(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
//     child: ListView.separated(
//         physics: const BouncingScrollPhysics(),
//         shrinkWrap: true,
//         itemBuilder: ((context, index) {
//           return MusicList(
//             leadImage: recentSong[index]['leadImage'],
//             songName: recentSong[index]['songName'],
//             singerName: recentSong[index]['singerName'],
//             favour: Colors.red[800],
//           );
//         }),
//         separatorBuilder: (context, index) {
//           return const SizedBox(
//             height: 10,
//           );
//         },
//         itemCount: recentSong.length),
//   );
// }