import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class Podcast extends StatefulWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  _PodcastState createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  bool isLoading = false;
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late List<Song> songs;
  late final Song song;

  // Déclaration de la liste de chansons
  int currentSongIndex = 0;
  String currentSongTitle = '';
  String currentSongImage = '';

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    init();
  }

  @override
  void dispose() {
    audioPlayer.stop(); // Arrêter la lecture lorsque le widget est supprimé
    super.dispose();
  }

  void playNextSong() {
    if (currentSongIndex < songs.length - 1) {
      currentSongIndex++;
      audioPlayer.stop(); // Arrêter la lecture de la chanson actuelle
      audioPlayer
          .play(songs[currentSongIndex].audio); // Jouer la chanson suivante
      setState(() {
        isPlaying = true; // Marquer comme en lecture
        updateCurrentSongInfo(); // Mettre à jour les informations de la chanson en cours
      });
    }
  }

  void prevSong() {
    if (currentSongIndex > 0) {
      currentSongIndex--;
      audioPlayer.stop(); // Arrêter la lecture de la chanson actuelle
      audioPlayer
          .play(songs[currentSongIndex].audio); // Jouer la chanson précédente
      setState(() {
        isPlaying = true; // Marquer comme en lecture
        updateCurrentSongInfo(); // Mettre à jour les informations de la chanson en cours
      });
    }
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    List<Song> fetchedSongs = await fetchSongs();
    setState(() {
      songs = fetchedSongs;
      isLoading = false;
    });
    // Démarrer la lecture automatiquement une fois que les chansons sont chargées
    playOrPause();
  }

  Future<List<Song>> fetchSongs() async {
    List<Song> fetchedSongs = [];
    List data = await Supabase.instance.client
        .from('cktvPodcast')
        .select()
        .order('id', ascending: false)
        .execute()
        .then((response) => response.data as List)
        .catchError((error) => print('Error fetching songs: $error'));

    if (data.isNotEmpty) {
      fetchedSongs = data.map((e) => Song.fromJson(e)).toList();
    }
    return fetchedSongs;
  }

  void playOrPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(songs[currentSongIndex]
          .audio); // Jouer la première chanson pour la démonstration
    }
    setState(() {
      isPlaying = !isPlaying;
      updateCurrentSongInfo(); // Mettre à jour les informations de la chanson en cours
    });
  }

  void updateCurrentSongInfo() {
    currentSongTitle = songs[currentSongIndex].titre;
    currentSongImage = songs[currentSongIndex].image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181A20),
      appBar: AppBar(
        title: const Text('Podcast'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Column(
                children: [
                  Image.network(currentSongImage),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 40, left: 40, bottom: 20, top: 30),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            value: 0.7,
                            backgroundColor: Color(0xff22242A),
                            color: Color(0xff3F51FC),
                            semanticsLabel: 'Progress',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous),
                              onPressed: prevSong,
                              color: Colors.white60,
                              iconSize: 36,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              icon: Icon(isPlaying
                                  ? Icons.pause_circle_outline
                                  : Icons.play_circle_outline),
                              onPressed: playOrPause,
                              color: Colors.white60,
                              iconSize: 60,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_next),
                              onPressed: playNextSong,
                              color: Colors.white60,
                              iconSize: 36,
                            ),
                          ],
                        ),
                        Text(
                          " Vous ecoutez $currentSongTitle",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Song {
  final String titre;
  final String image;
  final String audio;
  final String date;

  Song({
    required this.titre,
    required this.audio,
    required this.date,
    required this.image,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      titre: json['titre'] as String,
      audio: json['audio'] as String,
      image: json['image'] as String,
      date: json['date'] as String,
    );
  }
}
