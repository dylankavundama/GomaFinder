import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upato/Screen/Tv/PagedeLecture.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoItem {
  final String title;
  final String videoUrl;

  final String img;

  VideoItem(this.title, this.videoUrl, this.img);
}

class Channel extends StatelessWidget {
  final List<VideoItem> videos = [
    VideoItem('Vidéo 1', 'https://stream.ecable.tv/afrobeats/index.m3u8', ''),
    VideoItem('Vidéo 2', 'https://live-hls-web-aje.getaj.net/AJE/01.m3u8', ''),
    VideoItem(
        'Vidéo 3',
        'https://raw.githubusercontent.com/ipstreet312/freeiptv/master/ressources/dmotion/py/eqpe/equipe.m3u8',
        ''),
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
            return Card(
              child: ListTile(
                title: Text(
                  style: GoogleFonts.aBeeZee(fontSize: 16),
                  videos[index].title,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocalLecture(
                        titre: '',
                        video: videos[index].videoUrl,
                      ),
                    ),
                  );
                },
                         leading: CircleAvatar(
            backgroundImage: NetworkImage(    videos[index].img),
            radius: 25,
          ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final List<VideoItem> videoItems;
  final int initialIndex;

  VideoPlayerScreen({required this.videoItems, required this.initialIndex});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _videoPlayerController = VideoPlayerController.network(
        widget.videoItems[_currentIndex].videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture de la vidéo'),
      ),
      body: Column(
        children: [
          Chewie(controller: _chewieController),
          SizedBox(height: 20),
          Text(
            widget.videoItems[_currentIndex].title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
