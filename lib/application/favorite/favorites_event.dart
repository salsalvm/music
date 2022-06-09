part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}
class FavIconPress extends FavoritesEvent{
final  IconData icon;

  FavIconPress({required this.icon});
}