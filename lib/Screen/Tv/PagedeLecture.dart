import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class LocalLecture extends StatefulWidget {
  const LocalLecture({required this.video, required this.titre, Key? key})
      : super(key: key);
  final String video;
  final String titre;

  @override
  State<LocalLecture> createState() => _LocalLectureState();
}

class _LocalLectureState extends State<LocalLecture> {
  late VideoPlayerController _videoPlayerController1;

  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    // Déverrouiller l'orientation après avoir quitté l'écran de lecture
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Future<void> initializePlayer() async {
    String url = widget.video;
    _videoPlayerController1 = VideoPlayerController.network(url);

    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    // Verrouiller l'orientation en mode paysage lors de la lecture de la vidéo
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {});
  }

  void _createChewieController() {
    final subtitles = [

    ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
   //  subtitle: Subtitles(subtitles),

      //  hideControlsOnInitialize: true,
      showControlsOnInitialize: false,
      allowFullScreen: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
                controller: _chewieController!,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Chargement'),
                ],
              ),
      ),
    );
  }
}
