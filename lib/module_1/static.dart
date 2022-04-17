// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:music/module_1/home_widget.dart';
// import 'package:music/widget.dart';

// class Home extends StatelessWidget {
//   const Home({ Key? key }) : super(key: key);

//    Widget build(BuildContext context) {
//      double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//     return DefaultTabController(
      
//       length: 3,
//       child: Scaffold(
//           appBar: AppBar(
//               elevation: 3,
//               bottom: const TabBar(
//                 tabs: [
//                   Tab(
//                     icon: Icon(Icons.home),
//                     text: 'Home',
//                   ),
//                   Tab(
//                     icon: Icon(EvaIcons.heart),
//                     text: 'favorites',
//                   ),
//                   Tab(
//                     icon: Icon(Icons.restore),
//                     text: 'Recent',
//                   ),
//                 ],
//                 labelColor: Colors.white,
//               ),
//               title: const Text(
//                 'Home',
//               ),
//               centerTitle: true,
//               leading: IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.menu_outlined,
//                     size: 30,
//                   )),
            
   
//               actions: [
//                 IconButton(onPressed: () {}, icon: const Icon(Icons.search))
//               ],
//               backgroundColor: lightBlue
//              ),
//           body: Stack(
//             children: 
//               [Container(
//                 decoration: BoxDecoration(color: lightBlue),
//                 child: TabBarView(
//                   children: [
          
//                     //  home 
//                     //      
//                     SingleChildScrollView(
//                       child: SafeArea(
//                         child: SafeArea(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15.0, vertical: 13),
//                             child: ListView.separated(
//                                 physics: const BouncingScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemBuilder: ((context, index) {
//                                   return MusicList(
//                                     leadImage: musicCollection[index]['leadImage'],
//                                     songName: musicCollection[index]['songName'],
//                                     singerName: musicCollection[index]
//                                         ['singerName'],
//                                     favour: index % 4 == 0? Colors.white: Colors.red[800],
//                                   );
//                                 }),
//                                 separatorBuilder: (context, index) {
//                                   return const SizedBox(
//                                     height: 10,
//                                   );
//                                 },
//                                 itemCount: musicCollection.length),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // favourite 
                  
//                    SingleChildScrollView(
//                       child: SafeArea(
//                         child: SafeArea(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15.0, vertical: 13),
//                             child: ListView.separated(
//                                 physics: const BouncingScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemBuilder: ((context, index) {
//                                   return MusicList(
//                                     leadImage: favoritesSong[index]['leadImage'],
//                                     songName: favoritesSong[index]['songName'],
//                                     singerName: favoritesSong[index]['singerName'],
//                                     favour: Colors.red[800],
//                                   );
//                                 }),
//                                 separatorBuilder: (context, index) {
//                                   return const SizedBox(
//                                     height: 10,
//                                   );
//                                 },
//                                 itemCount: favoritesSong.length),
//                           ),
//                         ),
//                       ),
//                     ),
          
//               //  recent  
                 
//                     SingleChildScrollView(
//                       child: SafeArea(
//                         child: SafeArea(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15.0, vertical: 13),
//                             child: ListView.separated(
//                                 physics: const BouncingScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemBuilder: ((context, index) {
//                                   return MusicList(
//                                     leadImage: recentSong[index]['leadImage'],
//                                     songName: recentSong[index]['songName'],
//                                     singerName: recentSong[index]['singerName'],
//                                     favour: Colors.red[800],
//                                   );
//                                 }),
//                                 separatorBuilder: (context, index) {
//                                   return const SizedBox(
//                                     height: 10,
//                                   );
//                                 },
//                                 itemCount: recentSong.length),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';

// class demo extends StatefulWidget {
//   @override
//   _demoState createState() => _demoState();
// }

// class _demoState extends State<demo> {
//   bool status = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("FlutterSwitch Demo"),
//       ),
//       body: Container(
//         child: FlutterSwitch(
//           width: 50.0,
//           height: 25.0,
//           valueFontSize: 10.0,
//           toggleSize: 15.0,
//           value: status,
//           borderRadius: 35.0,
//           padding: 8.0,
//           showOnOff: true,
//           onToggle: (val) {
//             setState(() {
//               status = val;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }