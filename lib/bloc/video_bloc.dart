// import 'package:cktv/bloc/bloc_event.dart';
// import 'package:cktv/bloc/block_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'dart:core';

// import 'package:upato/bloc/block_state.dart';

// class VideoBloc extends Bloc<BlocEvent, BlocState> {
//   VideoBloc() : super(BlocStateUninitialized()) {
//     on<BlocEventFetch>(_onBlocEventFetch);
//     on<BlocEventSearchVideoFetch>(_onBlocEventSearchFetch);
//   }
//   void _onBlocEventSearchFetch(event, emit) async {
//     emit(BlocStateLoading());
//     try {
//       final data = await Supabase.instance.client
//           .from('cktvVideo')
//           .select()
//           .ilike('titre', '%${event.search}%')
//           .order('id', ascending: false);

//       debugPrint(
//         data.toString(),
//       );
//       if (data == null) {
//         emit(BlocStateError(error: null));
//       } else {
//         List list = data.map((json) => Video.fromJson(json)).toList();
//         debugPrint(list.toString());
//         emit(BlocStateLoaded(data: list));
//       }
//     } catch (e) {
//       print("Error fetching all ====> ${e.toString()}");
//       emit(BlocStateError(error: e));
//     }
//   }

//   void _onBlocEventFetch(event, emit) async {
//     emit(BlocStateLoading());
//     try {
//       final data = await Supabase.instance.client
//           .from('cktvVideo')
//           .select()
//           .order('id', ascending: false);
//       ;
//       debugPrint(
//         data.toString(),
//       );
//       if (data == null) {
//         emit(
//           BlocStateError(error: null),
//         );
//       } else {
//         List list = data.map((json) => Video.fromJson(json)).toList();
//         debugPrint(
//           list.toString(),
//         );
//         emit(
//           BlocStateLoaded(data: list),
//         );
//       }
//     } catch (e) {
//       print("Error fetching all ====> ${e.toString()}");
//       emit(
//         BlocStateError(error: e),
//       );
//     }
//   }
// }

// class Video {
//   final int id;
//   final String video;
//   final String img;
//   final String titre;

//   Video({
//     required this.id,
//     required this.video,
//     required this.img,
//     required this.titre,
//   });

//   factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
// }

// Video _$VideoFromJson(Map<String, dynamic> json) {
//   return Video(
//     id: json['id'] as int,
//     img: json['image'] as String,
//     titre: json['titre'] as String,
//     video: json['video'] as String,
//   );
// }

// class BlocEventSearchVideoFetch extends BlocEvent {
//   final String? search;
//   BlocEventSearchVideoFetch({this.search});
//   @override
//   String toString() => 'BlocEventSearchVideoFetch';
// }
