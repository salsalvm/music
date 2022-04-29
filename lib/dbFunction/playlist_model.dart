import 'package:hive/hive.dart';
@HiveType(typeId: 0)
class PlaylistModel {
  @HiveField(0)
  String? artist;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  String? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  String? id;
  PlaylistModel(
      {required this.id,
      required this.artist,
      required this.duration,
      required this.songname,
      required this.songurl});
}
String boxname="songs";
class PlaylistBox {
  static Box<List>?_box;
  static Box<List> getInstance(){
    return _box ??=Hive.box(boxname);
  }
}