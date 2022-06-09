part of 'playlist_bloc.dart';

 class PlaylistState {
  final IconData icon;

  PlaylistState({required this.icon});
}

class PlaylistInitial extends PlaylistState {
  PlaylistInitial() : super(icon: Icons.add);
}
