import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upato/Screen/Tv/PagedeLecture.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../Util/style.dart';

class VideoItem {
  final String title;
  final String videoUrl;
  final String img;
  VideoItem(this.title, this.videoUrl, this.img);
}

class Channel extends StatelessWidget {
  final List<VideoItem> videos = [
    VideoItem('Vidéo 1', 'https://stream.ecable.tv/afrobeats/index.m3u8',
        'data:image/jpeg;base64,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'),
    VideoItem('Vidéo 2', 'https://live-hls-web-aje.getaj.net/AJE/01.m3u8',
        'https://www.blind-magazine.com/wp-content/uploads/2021/12/format-portrait-ou-paysage-que-choisir-fr.jpg'),
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
          iconTheme: IconThemeData(color: CouleurPrincipale),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 0),
              ),
              Text(
                'Televison',
                style: TitreStyle,
              ),
            ],
          ),
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
                trailing: Icon(Icons.play_circle, color: CouleurPrincipale),
                leading: Image.asset("assets/tv.png"),
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

  const VideoPlayerScreen(
      {required this.videoItems, required this.initialIndex});

  @override
  // ignore: library_private_types_in_public_api
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
    // ignore: deprecated_member_use
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
        title: const Text('Lecture de la vidéo'),
      ),
      body: Column(
        children: [
          Chewie(controller: _chewieController),
          const SizedBox(height: 20),
          Text(
            widget.videoItems[_currentIndex].title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
