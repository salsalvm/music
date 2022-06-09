import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial(songDetails: fullSongs));

  void searchSong(String query) {
    final searched = fullSongs
        .toList()
        .where((element) =>
            element.metas.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(SearchInitial(songDetails: searched));
  }
}
