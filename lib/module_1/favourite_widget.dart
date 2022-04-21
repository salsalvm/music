// import 'package:flutter/material.dart';
// import 'package:music/module_1/home_widget.dart';

// List<Map<String, dynamic>> favoritesSong = [
//   {
//     "leadImage": "lib/assets/bheeshma.jpeg",
//     "songName": "Parudheesa",
//     "singerName": "sree nadh bhasi",
//   },
//   {
//     "leadImage": "lib/assets/dingiri.webp",
//     "songName": "Dingiri Dingale",
//     "singerName": "dulquar salman",
//   },
//   {
//     "leadImage": "lib/assets/uyire.webp",
//     "songName": "Uyire",
//     "singerName": "narayani",
//   },
//   {
//     "leadImage": "lib/assets/fakelove.webp",
//     "songName": "Fake love",
//     "singerName": "bts",
//   },
//   {
//     "leadImage": "lib/assets/agarthum.webp",
//     "songName": "Agar thum saath",
//     "singerName": "arjith sing",
//   },
//   {
//     "leadImage": "lib/assets/nee mukhilo.webp",
//     "songName": "Nee mukhilo",
//     "singerName": "sithara",
//   },
//   {
//     "leadImage": "lib/assets/pal.webp",
//     "songName": "Pal",
//     "singerName": "arjith sing",
//   }
// ];

// // favourites

// Widget favouriteListview() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
//     child: ListView.separated(
//         physics: const BouncingScrollPhysics(),
//         shrinkWrap: true,
//         itemBuilder: ((context, index) {
//           return MusicList(
//             leadImage: favoritesSong[index]['leadImage'],
//             songName: favoritesSong[index]['songName'],
//             singerName: favoritesSong[index]['singerName'],
//             favour: Colors.red[800],
//           );
//         }),
//         separatorBuilder: (context, index) {
//           return const SizedBox(
//             height: 10,
//           );
//         },
//         itemCount: favoritesSong.length),
//   );
// }
