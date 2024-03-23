import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

void main() {
  runApp(MyApp());
}

class VideoItem {
  final String title;
  final String videoUrl;

  VideoItem(this.title, this.videoUrl);
}

class MyApp extends StatelessWidget {
  final List<VideoItem> videos = [
    VideoItem('Vidéo 1', 'https://stream.ecable.tv/afrobeats/index.m3u8'),
    VideoItem('Vidéo 2', 'https://live-hls-web-aje.getaj.net/AJE/01.m3u8'),
    VideoItem('Vidéo 3', 'https://raw.githubusercontent.com/ipstreet312/freeiptv/master/ressources/dmotion/py/eqpe/equipe.m3u8'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Liste des vidéos'),
        ),
        body: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(videoUrl: videos[index].videoUrl),
                  ),
                );
              },
              child: ListTile(
                title: Text(videos[index].title),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late IjkMediaController controller;

  @override
  void initState() {
    super.initState();
    controller = IjkMediaController();
    controller.setNetworkDataSource(widget.videoUrl, autoPlay: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture de la vidéo'),
      ),
      body: Container(
        child: IjkPlayer(
          mediaController: controller,
        ),
      ),
    );
  }
}
