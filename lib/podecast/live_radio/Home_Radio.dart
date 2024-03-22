import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upato/podecast/live_radio/PlayingControls.dart';
import 'package:upato/podecast/live_radio/SongsSelector.dart';

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
        backgroundColor: Colors.white,
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
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: myAudio.metas.image?.path == null
                                        ? AssetImage('assets/default_image.jpg')
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
                            audioFocusStrategy: const AudioFocusStrategy.request(
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
