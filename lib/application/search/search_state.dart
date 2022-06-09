part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {
  final List<Audio> songDetails;

  SearchInitial({required this.songDetails});
}
