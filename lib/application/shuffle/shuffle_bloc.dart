import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'shuffle_event.dart';
part 'shuffle_state.dart';

class ShuffleBloc extends Bloc<ShuffleEvent, ShuffleState> {
  ShuffleBloc() : super(ShuffleInitial()) {
on<ShuffleIconPress>((event, emit) => emit(ShuffleState(icon: Icons.shuffle)));

  }
}
