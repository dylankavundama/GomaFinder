import 'package:cktv/Inedit/LocalWidget.dart';
import 'package:cktv/Inedit/PagedeLecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_event.dart';
import '../bloc/block_state.dart';
import 'Local_bloc.dart';

class LocalHome extends StatefulWidget {
  const LocalHome({Key? key}) : super(key: key);
  @override
  State<LocalHome> createState() => _LocalHomeState();
}

class _LocalHomeState extends State<LocalHome> {
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
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: BlocBuilder(
            bloc: _blocLocal,
            builder: (context, state) {
              if (state is BlocStateUninitialized ||
                  state is BlocStateLoading) {
                return const Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
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
                      ));
                }
              }
              return const Text('');
            }),
      ),
    );
  }
}
