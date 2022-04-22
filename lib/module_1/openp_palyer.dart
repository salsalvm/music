import 'package:assets_audio_player/assets_audio_player.dart';



class OpenPlayer {
  List<Audio> fullSongs;
  int index;
  bool? notify;
  

  OpenPlayer({required this.fullSongs, required this.index});

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
  }
}