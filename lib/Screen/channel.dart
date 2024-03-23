import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upato/Screen/Tv/PagedeLecture.dart';
import '../Util/style.dart';

class VideoItem {
  final String title;
  final String videoUrl;

  VideoItem(
    this.title,
    this.videoUrl,
  );
}

class Channel extends StatelessWidget {
  final List<VideoItem> videos = [

    VideoItem('','http://cdn.raino.xyz/hls/stream2.m3u8'),
VideoItem('EDGEsport','https://edgesports-sportstribal.amagi.tv/playlist.m3u8'),

    VideoItem('Nasa TV','https://ntv1.akamaized.net/hls/live/2014075/NASA-NTV1-HLS/master_2000.m3u8'),
    VideoItem(
      'Afrobeats',
      'https://stream.ecable.tv/afrobeats/index.m3u8',
    ),
    VideoItem(
      'Rakuten-family',
      'https://rakuten-family-16-be.samsung.wurl.tv/playlist.m3u8',
    ),
    VideoItem(
      "L'equipe",
      'https://raw.githubusercontent.com/ipstreet312/freeiptv/master/ressources/dmotion/py/eqpe/equipe.m3u8',
    ),
    VideoItem('Rakuten-africanews',
        'https://rakuten-africanews-2-be.samsung.wurl.tv/manifest/playlist.m3u8'),
    VideoItem('Moviesphereuk',
        'https://moviesphereuk-samsunguk.amagi.tv/playlist.m3u8'),
    VideoItem('Nrj12',
        'https://nrj12.nrjaudio.fm/hls/live/2038374/nrj_12/master.m3u8'),
    VideoItem('Rakuten-films-francais',
        'https://rakuten-films-francais-1-eu.rakuten.wurl.tv/playlist.m3u8'),
    VideoItem('BBlackafrica',
        'http://livevideo.vedge.infomaniak.com/livecast/ik:bblackafrica/manifest.m3u8'),
    VideoItem('Rakuten-actionmovies',
        'https://rakuten-actionmovies-1-eu.rakuten.wurl.tv/playlist.m3u8'),
    VideoItem('Rakuten-actionmovies-7',
        'https://rakuten-actionmovies-7-eu.rakuten.wurl.tv/playlist.m3u8'),
    VideoItem('BelArtTv',
        'https://rakutenaa-museumtv-fr-rakuten-nilyp.amagi.tv/playlist/rakutenAA-museumtv-fr-rakuten/playlist.m3u8'),
    VideoItem('Rakuten-comedymovies-7',
        'https://rakuten-comedymovies-7-eu.rakuten.wurl.tv/playlist.m3u8'),
    VideoItem('Rakuten-seriescrime',
        'https://rakuten-seriescrime-7-fr.lg.wurl.tv/playlist.m3u8'),
    VideoItem('Actionmovies',
        'https://rakuten-actionmovies-7-fr.plex.wurl.tv/playlist.m3u8'),
    VideoItem('Euronews',
        'https://rakuten-euronews-2-fr.samsung.wurl.tv/manifest/playlist.m3u8'),
    VideoItem('M6',
        'https://shls-m6-france-prod-dub.shahid.net/out/v1/c8a9f6e000cd4ebaa4d2fc7d18c15988/index.m3u8'),
    VideoItem('Tiji',
        'https://shls-tiji-tv-prod-dub.shahid.net/out/v1/98f46736bd8c4404b67e4b7a38cc8976/index.m3u8'),
    VideoItem('Tv Monaco',
        'https://production-fast-mcrtv.content.okast.tv/channels/2116dc08-1959-465d-857f-3619daefb66b/b702b2b9-aebd-436c-be69-2118f56f3d86/2024/media.m3u8'),
    VideoItem('TNT Sport',
        'http://89.187.167.93:80/live.ts?channelId=152&deviceUser=alex1234&devicePass=alex1234&uid=21890'),
    VideoItem('Sport MMM',
        'http://mmn.mypsx.net:1935/live/mmnhdsport/chunklist.m3u8'),
    VideoItem('Bsport1', 'https://edge1.laotv.la/live/Bsport1/index.m3u8'),
    VideoItem('Bsport2', 'https://edge1.laotv.la/live/Bsport2/index.m3u8'),
    VideoItem(
        'TrueSport6', 'https://edge1.laotv.la/live/TrueSport6/index.m3u8'),
    VideoItem('TNT Sport 1',
        'http://89.187.167.93:80/live.ts?channelId=152&deviceUser=alex1234&devicePass=alex1234&uid=2189'),
    VideoItem('nrjaudio',
        'https://cherie25.nrjaudio.fm/hls/live/2038375/c25/FHD.m3u8'),
    VideoItem('Tv5monde',
        'https://ott.tv5monde.com/Content/HLS/Live/channel(info)/variant.m3u8'),
    VideoItem('Sportsgrid', 'https://sportsgrid-plex.amagi.tv/playlist.m3u8'),
    VideoItem('RT', 'https://rt-fra.rttv.com/dvr/rtfrance/playlist.m3u8'),
    VideoItem('BBlack Classik',
        'http://livevideo.vedge.infomaniak.com/livecast/ik:bblackclassik/manifest.m3u8'),
    VideoItem('Bip Tv', 'https://biptv.tv/live/biptvstream_orig/index.m3u8'),
    VideoItem('',
        'https://raw.githubusercontent.com/ipstreet312/freeiptv/master/ressources/dmotion/py/eqpe/equipe.m3u8'),
    VideoItem('', 'https://srv.webtvmanager.fr:3697/stream/play.m3u8'),
    VideoItem(
        'ilTv', 'https://live.creacast.com/iltv/smil:iltv.smil/playlist.m3u8'),
    VideoItem('KTO',
        'https://live-kto.akamaized.net/hls/live/2033284/KTO/master.m3u8'),
    VideoItem('KSA Sports 1', 'https://edge.taghtia.com/sa/9.m3u8'),
    VideoItem('KSA Sports 2', 'https://edge.taghtia.com/sa/10.m3u8'),
    VideoItem('KSA Sports 3', 'https://edge.taghtia.com/sa/16.m3u8'),
    VideoItem('Dubai Sports 2',
        'https://dmitwlvvll.cdn.mangomolo.com/dubaisportshd/smil:dubaisportshd.smil/index.m3u8'),
    VideoItem('Dubai Sports 3',
        'https://dmitwlvvll.cdn.mangomolo.com/dubaisportshd5/smil:dubaisportshd5.smil/index.m3u8'),
    VideoItem('Dubai One',
        'https://dminnvll.cdn.mangomolo.com/dubaione/smil:dubaione.stream.smil/playlist.m3u8'),
    VideoItem('Sharjah Sport',
        'https://svs.itworkscdn.net/smc4sportslive/smc4.smil/playlist.m3u8')
  ];

  Channel({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
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
                        titre: videos[index].title,
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
