import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upato/style.dart';

class SongCard extends StatelessWidget {
  final Song song;

  const SongCard({required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerView(song: song),
          ),
        );
      },
      leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Image.network(song.image)),
      title:
          Text(song.titre, style: TextStyle(color: Colors.black, fontSize: 15)),
      subtitle: Text(song.date,
          style: GoogleFonts.abel(color: Colors.black, fontSize: 13)),
      trailing: Icon(Icons.play_arrow, color: CouleurPrincipale),
    );
  }
}

class PlayerView extends StatefulWidget {
  final Song song;

  PlayerView({required this.song});

  @override
  // ignore: library_private_types_in_public_api
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    playOrPause(); // Démarrer la lecture automatiquement
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playOrPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(widget.song.audio);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Intercepte le bouton de retour physique et de la barre d'applications Android
      onWillPop: () async {
        // Retourne true pour indiquer que vous avez géré le bouton de retour
        Navigator.pop(context);

        return false;
      },
      child: Scaffold(
            appBar: AppBar(
        iconTheme: IconThemeData(color: CouleurPrincipale),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 0),
            ),
            Text(
              'Lecture',
              style: DescStyle,
            ),
          ],
        ),
      ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Image de fond avec effet de flou
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.song
                        .image), // Utilisez l'image de l'audio en cours de lecture
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
                child: Padding(
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
                            itemCount: 1,
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
                                    (widget.song.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
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
                                ],
                              ),
                            ),
                            Text(
                              " Vous écoutez ${widget.song.titre}",
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
      ),
    );
  }
}

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

// Déclaration de la liste de chansons
  int currentSongIndex = 0;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    init();
  }

  @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();

  // }
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
      });
    }
  }

  void prevSong() {
    if (currentSongIndex < songs.length - 1) {
      currentSongIndex--;
      audioPlayer.stop(); // Arrêter la lecture de la chanson actuelle
      audioPlayer
          .play(songs[currentSongIndex].audio); // Jouer la chanson suivante
      setState(() {
        isPlaying = true; // Marquer comme en lecture
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
      audioPlayer.play(
          songs[0].audio); // Jouer la première chanson pour la démonstration
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'Music/Radio',
              style: DescStyle,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 40, left: 40, bottom: 20, top: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous),
                    onPressed: prevSong,
                    color: Colors.black,
                    iconSize: 36,
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: Icon(isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                    onPressed: playOrPause,
                    color: Colors.black,
                    iconSize: 60,
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(Icons.skip_next),
                    onPressed: playNextSong,
                    color: Colors.black,
                    iconSize: 36,
                  ),
                  const SizedBox(
                      width: 10), // Espacement entre les boutons et le titre
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Music non-stop",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: CouleurPrincipale,
            ))
          : ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => SongCard(song: songs[index]),
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
