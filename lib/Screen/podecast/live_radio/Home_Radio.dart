import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upato/Screen/podecast/live_radio/PlayingControls.dart';
import 'package:upato/Screen/podecast/live_radio/SongsSelector.dart';
import 'package:upato/Util/style.dart';

class HomeRadio extends StatefulWidget {
  @override
  _HomeRadioState createState() => _HomeRadioState();
}

class _HomeRadioState extends State<HomeRadio> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    Audio.network(
      'https://icepool.silvacast.com/DEFJAY.mp3',
      metas: Metas(
        title: 'feat Button Rose - Ndeke Remix .m4a',
        image: MetasImage.asset('assets/d.jpg'),
      ),
    ),
    Audio.network(
      'https://icecast4.play.cz/country128.mp3',
      metas: Metas(
        title: 'Feat Pson ZubaBoy _ Kucha ',
        image: const MetasImage.asset('assets/c.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Feat Robinio Soldat.m4a',
      metas: Metas(
        title: 'Feat Robinio Soldat ',
        image: const MetasImage.asset('assets/b.jpg'),
      ),
    ),
    Audio(
      'assets/audios/GoodVibe .m4a',
      metas: Metas(
        title: 'GoodVibe ',
        image: const MetasImage.asset('assets/a.jpg'),
      ),
    ),
  ];

  @override
  void initState() {
    _startNewGame();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    // Autres initialisations...
    openPlayer();

    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _assetsAudioPlayer.dispose();
    print('dispose');

    _interstitialAd?.dispose();

    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  bool _isLoading = true; // Variable pour suivre l'état de chargement

  @override

  // Fonction pour gérer le chargement des données
  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
    // Afficher le loader
    setState(() {
      _isLoading = true;
    });

    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );

    // Masquer le loader une fois le chargement terminé
    setState(() {
      _isLoading = false;
    });
  }

  ///
  //banniere actu
  BannerAd? _bannerAd;

  bool _isLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/5003791578'
      : 'ca-app-pub-7329797350611067/5003791578';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _isLoaded = false;
    _loadAd();
  }

  void _loadAd() async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
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
  }

  @override
  InterstitialAd? _interstitialAd;
  final _gameLength = 5;
  late var _counter = _gameLength;

  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/7003775471'
      : 'ca-app-pub-7329797350611067/7003775471';

  void _startNewGame() {
    setState(() => _counter = _gameLength);

    _loadAdd();
    _starTimer();
  }

  void _loadAdd() {
    InterstitialAd.load(
      adUnitId: _adUnitIdd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdClicked: (ad) {},
          );

          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void _starTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() => _counter--);

      if (_counter == 0) {
        _interstitialAd?.show();
        timer.cancel();
      }
    });
  }

  void go() {
    setState(() {
      _interstitialAd?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                'Radio/Music',
                style: DescStyle,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (_isLoading)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 111),
                        child: CircularProgressIndicator(
                          color: CouleurPrincipale,
                        ),
                      ),
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
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 130,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: myAudio.metas.image?.path == null
                                        ? const AssetImage(
                                            'assets/default_image.jpg')
                                        : myAudio.metas.image?.type ==
                                                ImageType.network
                                            ? NetworkImage(
                                                myAudio.metas.image!.path,
                                              )
                                            : AssetImage(
                                                myAudio.metas.image!.path,
                                              ) as ImageProvider,
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
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
                                    onPlay: () {
                                      _assetsAudioPlayer.playOrPause();
                                    },
                                    onNext: () {
                                      _assetsAudioPlayer.next(
                                        keepLoopMode: true,
                                      );
                                    },
                                    onPrevious: () {
                                      _assetsAudioPlayer.previous();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          _assetsAudioPlayer.builderRealtimePlayingInfos(
                            builder: (context, RealtimePlayingInfos? infos) {
                              if (infos == null) {
                                return const SizedBox();
                              }

                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      if (_bannerAd != null && _isLoaded)
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SafeArea(
                                            child: SizedBox(
                                              width: _bannerAd!.size.width
                                                  .toDouble(),
                                              height: _bannerAd!.size.height
                                                  .toDouble(),
                                              child: AdWidget(ad: _bannerAd!),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
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
                            audioFocusStrategy:
                                const AudioFocusStrategy.request(
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
}
