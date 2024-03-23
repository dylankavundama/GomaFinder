import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:upato/Screen/Tv/Tv_Home.dart';
import 'package:upato/Util/block_state.dart';
import 'dart:core';

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
          .from('iptv')
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
      emit(
        BlocStateError(error: e),
      );
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
    imgLocal: json['img'] as String,
    titreLocal: json['nom'] as String,
    videoLocal: json['link'] as String,
  );
}
