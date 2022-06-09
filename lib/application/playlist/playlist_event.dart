part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class PlaylistIconPress extends PlaylistEvent {
  final IconData icon;

  PlaylistIconPress({required this.icon});
}
