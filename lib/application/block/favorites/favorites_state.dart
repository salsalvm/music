part of '../favorites/favorites_bloc.dart';

 class FavoritesState {
   final IconData icon;

  FavoritesState({required this.icon});
   
 }

class FavoritesInitial extends FavoritesState {
  FavoritesInitial() : super(icon: Icons.favorite);
}
