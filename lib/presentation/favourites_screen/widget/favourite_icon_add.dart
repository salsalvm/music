
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/application/block/favorites/favorites_bloc.dart';
import 'package:music/presentation/favourites_screen/favourite_screen.dart';
import 'package:music/presentation/splash_screen/splash_Screen.dart';

class FavouriteIcon extends StatelessWidget {
  final String songId;

 const FavouriteIcon({Key? key, required this.songId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouritesSong = box.get("favourites");
    final fav = databaseSongs(dbSongs, songId);

    return
      
        BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return favouritesSong!
                .where((element) => element.id.toString() == fav.id.toString())
                .isEmpty
            ? IconButton(
                onPressed: () async {
                  favouritesSong.add(fav);

                  await box.put("favourites", favouritesSong);

                  context
                      .read<FavoritesBloc>()
                      .add(FavIconPress(icon: Icons.favorite));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ))
            : IconButton(
                onPressed: () async {
                  favouritesSong.removeWhere(
                      (element) => element.id.toString() == fav.id.toString());
                  await box.put("favourites", favouritesSong);
                  context
                      .read<FavoritesBloc>()
                      .add(FavIconPress(icon: Icons.favorite));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ));
      },
    );
  }
}