import 'package:cktv/bloc/bloc_event.dart';
import 'package:cktv/bloc/block_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:core';

class PostBloc extends Bloc<BlocEvent, BlocState> {
  PostBloc() : super(BlocStateUninitialized()) {
    on<BlocEventStoriesFetch>(_onBlocEventFetchStories);
  }

  void _onBlocEventFetchStories(event, emit) async {
    emit(BlocStateLoading());
    try {
      // final data = await fetchAllArticles(search: event.search);
      final data = await Supabase.instance.client
          .from('cktvPub')
          .select()
          .order('id', ascending: false);
      debugPrint(data.toString());
      if (data == null) {
        emit(BlocStateError(error: null));
      } else {
        List list = data.map((json) => Story.fromJson(json)).toList();
        debugPrint(list.toString());
        emit(BlocStateLoaded(data: list));
      }
    } catch (e) {
      print("Error fetching all ====> ${e.toString()}");
      emit(BlocStateError(error: e));
    }
  }
}

class Story {
  final int id;
  final String? img;
  final String? text;

  final String? titre;
  Story(
      {required this.titre,
      required this.id,
      required this.img,
      required this.text});
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
    id: json['id'] as int,
    img: json['img'] as String?,
    text: json['text'] as String?,
    titre: json['titre'] as String?,
  );
}
