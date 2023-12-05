///@file dice_roller.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'dart:math'; // Import for Random
import 'dart:async'; // Import for Timer
import 'common_drawer.dart';
import 'sound_settings_provider.dart';

/// DicePage is a stateful widget that displays a dice rolling simulation.
///
/// It integrates audio functionality to play a dice rolling sound and
/// uses [CommonDrawer] for consistent navigation.
class DicePage extends StatefulWidget {
  ///names the route to this page
  static const String routeName = '/dice_roller';
  final SoundSettingsProvider soundSettingsProvider;

  /// Constructor for DicePage.
  ///
  /// Takes an [AudioPlayer] and [SoundSettingsProvider] as parameters.
  DicePage({required this.soundSettingsProvider});

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  /// Current dice numbers for left and right dice.
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  /// Boolean to keep track if the dice are currently rolling.
  bool isRolling = false;

  /// Late initialization of the AudioPlayer.
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    initAudio();
  }

  /// Initializes the audio player with the dice rolling sound asset.
  Future<void> initAudio() async {
    await audioPlayer.setAsset('assets/dice_rolling_sound.mp3');
  }

  /// Plays the dice rolling sound if not muted.
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


  /// Simulates dice rolling with random values for each dice.
  Future<void> simulateRoll() async {
    if (!isRolling) {
      final Random random = Random();
      const int totalFrames = 10;
      const Duration frameDuration = Duration(milliseconds: 100);

      setState(() {
        isRolling = true;
      });

      Timer(Duration(milliseconds: 300), () async {
        for (int frame = 0; frame < totalFrames; frame++) {
          await Future.delayed(frameDuration);
          setState(() {
            leftDiceNumber = random.nextInt(6) + 1;
            rightDiceNumber = random.nextInt(6) + 1;
          });
        }

        setState(() {
          isRolling = false;
        });
      });

      playSound();
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
      currentPage: '/',
      appBarSubtitle: 'Dice Roller',
      bodyContent: _buildDicePageBody(),
    );
  }

  /// Builds the main body of the DicePage.
  ///
  /// Includes two dice images that can be tapped to simulate a dice roll.
  Widget _buildDicePageBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: simulateRoll,
                      child: Image.asset('assets/images/dice$leftDiceNumber.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: simulateRoll,
                      child: Image.asset('assets/images/dice$rightDiceNumber.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
