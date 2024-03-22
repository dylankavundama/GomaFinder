import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

class RadioModel {
  final String title;
  final String url;
  final String imagePath;

  RadioModel({
    required this.title,
    required this.url,
    required this.imagePath,
  });
}

class MyAppRadio extends StatefulWidget {
  @override
  _MyAppRadioState createState() => _MyAppRadioState();
}

class _MyAppRadioState extends State<MyAppRadio> {
  late RadioPlayer _radioPlayer;
  bool isPlaying = false;
  int selectedRadioIndex = 0;

  List<RadioModel> radioList = [
    RadioModel(
      title: 'Radio Player 1',
      url: 'https://rggeeykubskxurwxclwl.supabase.co/storage/v1/object/public/assets/Cktv/audio/e.mp3',
      imagePath: 'assets/cover1.jpg',
    ),
    RadioModel(
      title: 'Radio Player 2',
      url: 'https://rggeeykubskxurwxclwl.supabase.co/storage/v1/object/public/assets/Cktv/audio/d.mp3M',
      imagePath: 'assets/cover2.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _radioPlayer = RadioPlayer();
    initRadioPlayer();
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: radioList[selectedRadioIndex].title,
      url: radioList[selectedRadioIndex].url,
      imagePath: radioList[selectedRadioIndex].imagePath,
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Radio Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: _radioPlayer.getArtworkImage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Image artwork;
                  if (snapshot.hasData) {
                    artwork = snapshot.data;
                  } else {
                    artwork = Image.asset(
                      radioList[selectedRadioIndex].imagePath,
                      fit: BoxFit.cover,
                    );
                  }
                  return Container(
                    height: 180,
                    width: 180,
                    child: ClipRRect(
                      child: artwork,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                radioList[selectedRadioIndex].title,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: radioList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(radioList[index].title),
                      onTap: () {
                        setState(() {
                          selectedRadioIndex = index;
                          _radioPlayer.setChannel(
                            title: radioList[selectedRadioIndex].title,
                            url: radioList[selectedRadioIndex].url,
                            imagePath: radioList[selectedRadioIndex].imagePath,
                          );
                          _radioPlayer
                              .play(); // Démarrer la lecture automatiquement
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
          },
          tooltip: 'Control button',
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          ),
        ),
      ),
    );
  }
}
