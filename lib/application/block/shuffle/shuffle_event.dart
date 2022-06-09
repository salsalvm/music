part of 'shuffle_bloc.dart';

@immutable
abstract class ShuffleEvent {}
class ShuffleIconPress extends ShuffleEvent{
final IconData icon;

  ShuffleIconPress({required this.icon});
}