///@file coin_flipper.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'dart:math';
import 'common_drawer.dart';
import 'sound_settings_provider.dart';

/// CoinFlipper is a stateful widget that simulates a coin flip.
///
/// It includes audio functionality for added realism and uses a common drawer for navigation.
class CoinFlipper extends StatefulWidget {
  static const String routeName = '/coin_flipper';
  final SoundSettingsProvider soundSettingsProvider;

  /// Constructor for CoinFlipper.
  ///
  /// Takes [SoundSettingsProvider] to manage sound settings.
  CoinFlipper({required this.soundSettingsProvider});

  @override
  _CoinFlipPageState createState() => _CoinFlipPageState();
}

class _CoinFlipPageState extends State<CoinFlipper> {
  bool isFlipping = false;  // Tracks whether the coin is currently flipping
  bool showHeads = true;    // Tracks which side of the coin is showing
  late AudioPlayer audioPlayer;  // Audio player instance for coin flip sound

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    initAudio();
  }

  /// Initializes the audio player with the coin flip sound asset.
  Future<void> initAudio() async {
    await audioPlayer.setAsset('assets/coin_flip_sound.mp3');
  }
  /// Plays the coin flip sound if not muted.
  Future<void> playSound() async {
    final soundSettingsProvider = widget.soundSettingsProvider;

    try {
      if (!soundSettingsProvider.isMuted) {
        await audioPlayer.stop();
        await audioPlayer.seek(Duration.zero);
        await audioPlayer.play();
      } else if (audioPlayer.playing) {
        await audioPlayer.pause();
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  /// Simulates a coin flip with animation and random result.
  Future<void> flipCoin() async {
    if (!isFlipping) {
      playSound();

      setState(() {
        isFlipping = true;
      });

      await Future.delayed(Duration(milliseconds: 400));
      final Random random = Random();
      const int totalFrames = 12;
      const Duration frameDuration = Duration(milliseconds: 50);

      for (int frame = 0; frame < totalFrames; frame++) {
        await Future.delayed(frameDuration);
        setState(() {
          showHeads = !showHeads;
        });
      }

      setState(() {
        isFlipping = false;
        showHeads = random.nextBool();
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDrawer(
      currentPage: CoinFlipper.routeName,
      appBarSubtitle: 'Coin Flipper',
      bodyContent: _buildCoinFlipperBody(),
    );
  }

  /// Builds the main body of the CoinFlipper page.
  ///
  /// Includes an interactive coin image that can be tapped to simulate a flip.
  Widget _buildCoinFlipperBody() {
    return Container(
      color: Colors.black, // Set the background color to black
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (!isFlipping) {
              flipCoin();
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Image.asset(
              showHeads ? 'assets/images/heads_coin.jpg' : 'assets/images/tails_coin.jpg',
              key: ValueKey<bool>(showHeads),
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
