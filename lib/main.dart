///@file main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import 'dice_roller.dart';
import 'yugioh_life_points_page.dart';
import 'mtg_life_points_page.dart';
import 'coin_flipper.dart';
import 'sound_settings_provider.dart';
import 'settings_page.dart';
import 'landing_page.dart';
import 'game_data_provider.dart';

/// Main entry point for the application.
///
/// Initializes the application and sets up the necessary providers and routes.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final soundSettingsProvider = SoundSettingsProvider();
  await soundSettingsProvider.loadMuteState();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameData()), // Add GameData provider
        ChangeNotifierProvider.value(value: soundSettingsProvider),
      ],
      child: MyApp(soundSettingsProvider: soundSettingsProvider),
    ),
  );
}

/// MyApp is the main widget for the application.
///
/// This widget sets up the MaterialApp and defines the routes for the app.
class MyApp extends StatelessWidget {
  final SoundSettingsProvider soundSettingsProvider;

  MyApp({required this.soundSettingsProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LandingPage.routeName,
      routes: {
        LandingPage.routeName: (context) => LandingPage(),
        DicePage.routeName: (context) => DicePage(soundSettingsProvider: soundSettingsProvider),
        CoinFlipper.routeName: (context) => CoinFlipper(soundSettingsProvider: soundSettingsProvider),
        YugiohLifePointsPage.routeName: (context) => YugiohLifePointsPage(),
        MTGLifePointsPage.routeName: (context) => MTGLifePointsPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
      },
    );
  }
}