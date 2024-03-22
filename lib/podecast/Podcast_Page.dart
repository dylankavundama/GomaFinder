import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class SongCard extends StatelessWidget {
  final Song song;

  SongCard({required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(song.image),
      title:
          Text(song.titre, style: TextStyle(color: Colors.white, fontSize: 15)),
      subtitle: Text(song.date,
          style: GoogleFonts.abel(color: Colors.white, fontSize: 13)),
      trailing: IconButton(
        icon: Icon(Icons.play_arrow, color: Colors.orange),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerView(song: song),
            ),
          );
        },
      ),
    );
  }
}

class PlayerView extends StatefulWidget {
  final Song song;

  PlayerView({required this.song});

  @override
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
        // Retourne false pour empêcher la navigation arrière par défaut
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.song.titre),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display song details
              Text(widget.song.titre, style: const TextStyle(fontSize: 20)),
              Text(widget.song.date),

              // Play/Pause button
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: playOrPause,
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
      backgroundColor: Color(0xff181A20),
      bottomNavigationBar: Container(
        height: 150,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 40, left: 40, bottom: 20, top: 30),
          child: Container(
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
                  children: [
                    IconButton(
                      icon: const Icon(Icons
                          .skip_next), // Utiliser l'icône de skip_next pour le bouton Next
                      onPressed:
                          prevSong, // Appeler la fonction pour passer à la chanson suivante
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
                      icon: Icon(Icons
                          .skip_next), // Utiliser l'icône de skip_next pour le bouton Next
                      onPressed:
                          playNextSong, // Appeler la fonction pour passer à la chanson suivante
                      color: Colors.white60,
                      iconSize: 36,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      "EKISDE",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "artista",
                      style: TextStyle(color: Colors.white30),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "2:32",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
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
