import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'repeat_event.dart';
part 'repeat_state.dart';

class RepeatBloc extends Bloc<RepeatEvent, RepeatState> {
  RepeatBloc() : super(RepeatInitial()) {
    on<RepeatIconPress>((event, emit) => emit(RepeatState(icon: event.icon)));
  }
}
