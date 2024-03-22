import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:core';

import '../bloc/bloc_event.dart';
import '../bloc/block_state.dart';

class BlocSearchLocal extends BlocEvent {
  final String? search;
  BlocSearchLocal({this.search});
  @override
  String toString() => 'BlocSearchLocal';
}

class LocalBloc extends Bloc<BlocEvent, BlocState> {
  LocalBloc() : super(BlocStateUninitialized()) {
    on<BlocEventFetch>(_onBlocEventFetch);
  }

  void _onBlocEventFetch(event, emit) async {
    emit(BlocStateLoading());
    try {
      final data = await Supabase.instance.client
          .from('cktvInedit')
          .select()
          .order('id', ascending: false);
      ;
      debugPrint(data.toString());
      if (data == null) {
        emit(BlocStateError(error: null));
      } else {
        List list = data.map((json) => LocalVideo.fromJson(json)).toList();
        debugPrint(list.toString());
        emit(BlocStateLoaded(data: list));
      }
    } catch (e) {
      emit(BlocStateError(error: e));
    }
  }
}

class LocalVideo {
  final int id;
  final String videoLocal;
  final String imgLocal;
  final String titreLocal;

  LocalVideo({
    required this.id,
    required this.videoLocal,
    required this.imgLocal,
    required this.titreLocal,
  });

  factory LocalVideo.fromJson(Map<String, dynamic> json) =>
      _$VideoFromJson(json);
}

LocalVideo _$VideoFromJson(Map<String, dynamic> json) {
  return LocalVideo(
    id: json['id'] as int,
    imgLocal: json['image'] as String,
    titreLocal: json['titre'] as String,
    videoLocal: json['video'] as String,
  );
}
