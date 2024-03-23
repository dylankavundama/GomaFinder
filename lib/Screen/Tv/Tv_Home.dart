import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upato/Screen/Tv/LocalWidget.dart';
import 'package:upato/Screen/Tv/PagedeLecture.dart';
import 'package:upato/Util/block_state.dart';
import 'package:upato/Util/style.dart';

import 'Local_bloc.dart';

class Tv_Home extends StatefulWidget {
  const Tv_Home({Key? key}) : super(key: key);
  @override
  State<Tv_Home> createState() => _Tv_HomeState();
}

class _Tv_HomeState extends State<Tv_Home> {
  @override
  void dispose() {
    super.dispose();
  }

  final LocalBloc _blocLocal = LocalBloc();
  @override
  void initState() {
    _blocLocal.add(BlocEventFetch());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
    appBar: AppBar(
        iconTheme: IconThemeData(color: CouleurPrincipale),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 0),
            ),
            Text(
              'Televison',
              style: DescStyle,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocBuilder(
            bloc: _blocLocal,
            builder: (context, state) {
              if (state is BlocStateUninitialized ||
                  state is BlocStateLoading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: CouleurPrincipale,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              if (state is BlocStateLoaded) {
                if (state.data == null || state.data.isEmpty) {
                  return const Text('');
                } else {
                  return SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocalLecture(
                                  video: state.data[index].videoLocal,
                                  titre: state.data[index].titreLocal,
                                ),
                              ),
                            );
                          },
                          child: LocalWdget(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            imageLocal: state.data[index].imgLocal,
                            titreLocal: state.data[index].titreLocal,
                          ),
                        );
                      },
                    ),
                  );
                }
              }
              return const Text('');
            }),
      ),
    );
  }
}
abstract class BlocEvent {}


class BlocEventFetch extends BlocEvent {
  final String? data;
  final String? dateDebut;
  final String? dateFin;
  final String? search;
  final int? limit;
  BlocEventFetch(
      {this.data, this.dateDebut, this.dateFin, this.search, this.limit});
  @override
  String toString() => 'BlocEventFetch';
}


