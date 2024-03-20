import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:upato/style.dart';

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
    //audioPlayer.notificationService.setNotification;
    init();
  }

  @override
  void dispose() {
    // audioPlayer.notificationService; // Arrêter la lecture lorsque le widget est supprimé
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
        // ignore: deprecated_member_use
        .execute()
        .then((response) => response.data as List)
        // ignore: invalid_return_type_for_catch_error
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
  @override
  Widget build(BuildContext context) {
    //     SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.green,
    //     statusBarBrightness: Brightness.light,
    //   ),
    // );
    return Scaffold(
      
      // appBar: AppBar(
      //   title: Text('Podcast'),
      // ),
      body:
      
      isLoading
                  ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircularProgressIndicator(
                        color: CouleurPrincipale,
                      ),
                    ),
                  ) :
       SingleChildScrollView(
        child: Stack(
          children: [
            // Image de fond avec effet de flou
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      currentSongImage), // Utilisez l'image de l'audio en cours de lecture
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 5, sigmaY: 5), // Paramètres de flou
                child: Container(
                  color: Colors.black.withOpacity(
                      0.5), // Opacité pour rendre le flou plus visible
                ),
              ),
            ),
            Container(
              child: 
                  Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 300),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                  'https://media1.giphy.com/media/C8xhW9gBu5ToGl7vgs/200.gif?cid=6c09b952kwhbv9fgo8bo1yrbgpwblq5t8pkg555yze481458&ep=v1_internal_gif_by_id&rid=200.gif&ct=s'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 444, // Hauteur de votre image carrousel
                              child: PageView.builder(
                                itemCount: songs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 300, // Nouvelle hauteur de l'image
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(color: Colors.white, width: 2), // Bordure de l'image
                                    // ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10), // Arrondi des coins
                                      child: Image.network(
                                        songs[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                onPageChanged: (index) {
                                  setState(() {
                                    currentSongIndex = index;
                                    updateCurrentSongInfo();
                                    // Lire automatiquement le prochain audio lorsque vous faites défiler les images du carrousel
                                    if (index < songs.length - 0) {
                                      audioPlayer.play(songs[index + 0].audio);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
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
                                Card(
                                  color: Colors.black12,
                                  child: Row(
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
                                ),
                                Text(
                                  " Vous écoutez $currentSongTitle",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
