part of 'repeat_bloc.dart';

@immutable
abstract class RepeatEvent {}
class RepeatIconPress extends RepeatEvent{
final IconData icon;

  RepeatIconPress({required this.icon});
}