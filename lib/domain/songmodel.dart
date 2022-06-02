import 'package:hive/hive.dart';
part 'songmodel.g.dart';

@HiveType(typeId: 0)
class Songs extends HiveObject {
  @HiveField(0)
  String? artist;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  Songs(
      {required this.id,
      required this.artist,
      required this.duration,
      required this.songname,
      required this.songurl});
}

String boxname = "songs";

class StorageBox {
  static Box<List>? _box;
  static Box<List> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
