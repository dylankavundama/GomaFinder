// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';


// class AudioPlayerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Audio Player'),
//         ),
//         body: AudioPlayerWidget(),
//       ),
//     );
//   }
// }

// class AudioPlayerWidget extends StatefulWidget {
//   @override
//   _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
// }

// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   AudioPlayer audioPlayer = AudioPlayer();

//   @override
//   void dispose() {
//     audioPlayer.dispose(); // Release resources when widget is disposed
//     super.dispose();
//   }

//   void playAudio(String audioPath) async {
//     await audioPlayer.stop(); // Stop any currently playing audio
//     await audioPlayer.play(audioPath);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               playAudio('assets/audio/audio1.mp3');
//             },
//             child: Text('Play Audio 1'),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               playAudio('assets/audio/audio2.mp3');
//             },
//             child: Text('Play Audio 2'),
//           ),
//         ],
//       ),
//     );
//   }
// }
