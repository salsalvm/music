// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';

// import 'package:music/main.dart';
// import 'package:music/module_1/refactor/home_widget.dart';


// class PlayListSongsItems extends StatefulWidget {
  
  
//   const PlayListSongsItems({required this.playListName});

//   @override
//   State<PlayListSongsItems> createState() => _PlayListSongsItemsState();
// }

// class _PlayListSongsItemsState extends State<PlayListSongsItems> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(decoration: BoxDecoration(color: boxtColor,borderRadius: BorderRadius.circular(15)),
//       child: ListTile(
//           onTap: () {},
//           leading: CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.transparent,
//             backgroundImage: AssetImage(
//               widget.leadImage,
//             ),
//           ),
//           title: Padding(
//             padding: const EdgeInsets.only(left: 5.0, bottom: 3, top: 3),
//             child: Text(
//               widget.songName,
//               style: TextStyle(color: textWhite, fontSize: 18),
//             ),
//           ),
//           subtitle: Padding(
//             padding: const EdgeInsets.only(left: 5.0),
//             child: Text(
//               widget.singerName,
//               style: TextStyle(color: textGrey),
//             ),
//           ),
//           trailing: Wrap(
//             children: [
//               IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     EvaIcons.heart,
//                     size: 22,
//                     color: widget.favour,
//                   )),
            
//    PopupMenuButton(
//     color: darkBlue,
//     icon: Icon(
//       Icons.more_vert_outlined,
//       color: textWhite,
//     ), //don't specify icon if you want 3 dot menu
//     // color: Colors.blue,
//     itemBuilder: (context) => [
//       PopupMenuItem(
//         onTap: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 behavior: SnackBarBehavior.floating,
//                 backgroundColor: boxtColor,
//                 margin: EdgeInsets.all(10),
//                 content: Text('Playlist Removed')));},
//         value: 0,
//         child: Text(
//           "Remove from Playlist",
//           style: TextStyle(color: textWhite),
//         ),
//       ),
//       PopupMenuItem(
//         onTap: () {},
//         value: 1,
//         child: Text(
//           "View Details",
//           style: TextStyle(color: textWhite),
//         ),
//       ),
      
//     ],
//     onSelected: (item) => {print(item)},
//   )

//             ],
//           )),
//     );
//   }
// }

// List<Map<String, dynamic>> playListSong = [
//   {
//     "leadImage": "lib/assets/onakka mundhiry.webp",
//     "songName": "Onaka mundhiri",
//     "singerName": "vineedh sreenivasan",
//   },
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
//     "leadImage": "lib/assets/nee mukhilo.webp",
//     "songName": "Nee mukhilo",
//     "singerName": "sithara",
//   },

// ];