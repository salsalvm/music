import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/module_1/home.dart';
import 'package:music/module_1/splash_Screen.dart';
import 'package:music/module_3/favourite_screen.dart';

class OpenPlayer {
  List<Audio> fullSongs;
  int index;
  bool? notify;
  final String songId;
  OpenPlayer(
      {required this.fullSongs, required this.index, required this.songId});

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  openAssetPlayer({List<Audio>? songs, required int index}) async {
    player.open(
      Playlist(audios: songs, startIndex: index),
      showNotification: notify == null || notify == true ? true : false,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      playInBackground: PlayInBackground.enabled,
    );

    List? recentSongs = box.get("recentPlayed");
    final recent = databaseSongs(dbSongs, songId);
    recentSongs!
            .where((element) => element.id.toString() == recent.id.toString())
            .isEmpty
        ? addToRecent(recentSongs, recent)
        : sameIndexToRecent(recentSongs, recent);
  }
}

addToRecent(List recentSongs, recent) {
  if (recentSongs.length < 4) {
    recentSongs.add(recent);

    box.put("recentPlayed", recentSongs);
  } else {
    recentSongs.removeAt(0);
    recentSongs.add(recent);
    box.put("recentPlayed", recentSongs);
  }
}

sameIndexToRecent(List recentSongs, recent) {


    recentSongs.remove(recent);
    recentSongs.add(recent);
    box.put("recentPlayed", recentSongs);
 

}
