import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:upato/Util/style.dart';

class SongsSelector extends StatelessWidget {
  final Playing? playing;
  final List<Audio> audios;
  final Function(Audio) onSelected;
  final Function(List<Audio>) onPlaylistSelected;

  const SongsSelector({
    required this.playing,
    required this.audios,
    required this.onSelected,
    required this.onPlaylistSelected,
  });

  Widget _image(Audio item) {
    if (item.metas.image == null) {
      return const SizedBox(height: 50, width: 40);
    }

    return item.metas.image?.type == ImageType.network
        ? CircleAvatar(
            radius: 30,
            child: Image.network(
              item.metas.image!.path,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          )
        : Image.asset(
            item.metas.image!.path,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              onPlaylistSelected(audios);
            },
            child: Text(
              'Playlist',
              style: TitreStyle,
            ),
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, position) {
              final item = audios[position];
              final isPlaying = item.path == playing?.audio.assetAudioPath;
              return Card(
                color: isPlaying ? CouleurPrincipale : Colors.black,
                margin: const EdgeInsets.all(4),
                child: ListTile(
                  leading: Material(
                    color: Colors.black,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: _image(item),
                  ),
                  title: Text(
                    item.metas.title.toString(),
                    style: TextStyle(
                      color: isPlaying ? Colors.black : Colors.white,
                    ),
                  ),
                  onTap: () {
                    onSelected(item);
                  },
                ),
              );
            },
            itemCount: audios.length,
          ),
        ),
      ],
    );
  }
}
