import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upato/podecast/live_radio/PlayingControls.dart';
import 'SongsSelector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });

  runApp(
    NeumorphicTheme(
      theme: const NeumorphicThemeData(
        baseColor: Colors.black87,
        intensity: 0.0,
        lightSource: LightSource.topLeft,
      ),
      child: Home_Radio(),
    ),
  );
}

class Home_Radio extends StatefulWidget {
  @override
  _Home_RadioState createState() => _Home_RadioState();
}

class _Home_RadioState extends State<Home_Radio> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    Audio(
      'assets/audios/feat Button Rose - Ndeke Remix .m4a',
      metas: Metas(
        title: 'feat Button Rose - Ndeke Remix .m4a',
        image: MetasImage.asset('assets/d.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Feat Pson ZubaBoy _ Kucha.m4a',
      metas: Metas(
        title: 'Feat Pson ZubaBoy _ Kucha ',
        image: MetasImage.asset('assets/c.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Feat Robinio Soldat.m4a',
      metas: Metas(
        title: 'Feat Robinio Soldat ',
        image: MetasImage.asset('assets/b.jpg'),
      ),
    ),
    Audio(
      'assets/audios/GoodVibe .m4a',
      metas: Metas(
        title: 'GoodVibe ',
        image: MetasImage.asset('assets/a.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Hallelujah .mp3',
      metas: Metas(
        title: 'Hallelujah',
        image: MetasImage.asset('assets/d.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Kaloko_ Freestyle.m4a',
      metas: Metas(
        title: 'Kaloko_ Freestyle',
        image: MetasImage.asset('assets/c.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Love Story.m4a',
      metas: Metas(
        title: 'Love Story',
        image: MetasImage.asset('assets/b.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Mbongo Ya Mapa.mp3',
      metas: Metas(
        title: 'Mbongo Ya Mapa',
        image: MetasImage.asset('assets/a.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Mombasa.mp3',
      metas: Metas(
        title: 'Mombasa',
        image: MetasImage.asset('assets/d.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Mukeba.mp3',
      metas: Metas(
        title: 'Mukeba',
        image: MetasImage.asset('assets/c.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Ndeke.m4a',
      metas: Metas(
        title: 'Ndeke',
        image: MetasImage.asset('assets/b.jpg'),
      ),
    ),
    Audio(
      'assets/audios/a.mp3',
      metas: Metas(
        title: 'Umama .mp3',
        image: MetasImage.asset('assets/a.jpg'),
      ),
    ),
    Audio(
      'assets/audios/b.m4a',
      metas: Metas(
        title: 'TinaTine',
        image: MetasImage.asset('assets/d.jpg'),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();

    _startNewGame();
  }
  

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    _rewardedAd?.dispose();

    _bannerAd?.dispose();

    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/5705877032'
      : 'ca-app-pub-7329797350611067/5705877032';

  void _startNewGame() {
    _loadAd();
  }

  BannerAd? _bannerAd;

  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/5003791578'
      : 'ca-app-pub-7329797350611067/5003791578';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      StreamBuilder<Playing?>(
                          stream: _assetsAudioPlayer.current,
                          builder: (context, playing) {
                            if (playing.data != null) {
                              final myAudio = find(
                                  audios, playing.data!.audio.assetAudioPath);
                              print(playing.data!.audio.assetAudioPath);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: const NeumorphicStyle(
                                    //  color: Colors.black,
                                    depth: 8,
                                    surfaceIntensity: 1,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                  ),
                                  child: myAudio.metas.image?.path == null
                                      ? const SizedBox()
                                      : myAudio.metas.image?.type ==
                                              ImageType.network
                                          ? Image.network(
                                              myAudio.metas.image!.path,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.contain,
                                            )
                                          : Image.asset(
                                              myAudio.metas.image!.path,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.contain,
                                            ),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _assetsAudioPlayer.builderCurrent(
                      builder: (context, Playing? playing) {
                    return Column(
                      children: <Widget>[
                        _assetsAudioPlayer.builderLoopMode(
                          builder: (context, loopMode) {
                            return PlayerBuilder.isPlaying(
                                player: _assetsAudioPlayer,
                                builder: (context, isPlaying) {
                                  return PlayingControls(
                                    loopMode: loopMode,
                                    isPlaying: isPlaying,
                                    isPlaylist: true,
                                    onStop: () {
                                      _assetsAudioPlayer.stop();
                                    },
                                    toggleLoop: () {
                                      _assetsAudioPlayer.toggleLoop();
                                    },
                                    onPlay: () {
                                      _assetsAudioPlayer.playOrPause();
                                    },
                                    onNext: () {
                                      //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                      _assetsAudioPlayer.next(
                                          keepLoopMode:
                                              true /*keepLoopMode: false*/);
                                    },
                                    onPrevious: () {
                                      _assetsAudioPlayer.previous(
                                          /*keepLoopMode: false*/);
                                    },
                                  );
                                });
                          },
                        ),
                        _assetsAudioPlayer.builderRealtimePlayingInfos(
                            builder: (context, RealtimePlayingInfos? infos) {
                          if (infos == null) {
                            return SizedBox();
                          }
                          //print('infos: $infos');
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  if (_bannerAd != null)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SafeArea(
                                        child: SizedBox(
                                          width:
                                              _bannerAd!.size.width.toDouble(),
                                          height:
                                              _bannerAd!.size.height.toDouble(),
                                          child: AdWidget(ad: _bannerAd!),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  _assetsAudioPlayer.builderCurrent(
                      builder: (BuildContext context, Playing? playing) {
                    return SongsSelector(
                      audios: audios,
                      onPlaylistSelected: (myAudios) {
                        _assetsAudioPlayer.open(
                          Playlist(audios: myAudios),
                          showNotification: true,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          audioFocusStrategy: const AudioFocusStrategy.request(
                              resumeAfterInterruption: true),
                        );
                      },
                      onSelected: (myAudio) async {
                        try {
                          await _assetsAudioPlayer.open(
                            myAudio,
                            autoStart: true,
                            showNotification: true,
                            playInBackground: PlayInBackground.enabled,
                            audioFocusStrategy: AudioFocusStrategy.request(
                                resumeAfterInterruption: true,
                                resumeOthersPlayersAfterDone: true),
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            notificationSettings: const NotificationSettings(),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      playing: playing,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadAd() {
    BannerAd(
      adUnitId: _adUnitIdd,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
    setState(() {
      RewardedAd.load(
          adUnitId: _adUnitId,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          }, onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('RewardedAd failed to load: $error');
          }));
    });
  }
}
