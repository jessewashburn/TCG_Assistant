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

/// Main entry point for the application.
///
/// Initializes the application and sets up the necessary providers and routes.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final soundSettingsProvider = SoundSettingsProvider();
  await soundSettingsProvider.loadMuteState();
  runApp(
    ChangeNotifierProvider.value(
      value: soundSettingsProvider,
      child: MyApp(soundSettingsProvider: soundSettingsProvider),
    ),
  );
}

/// MyApp is the main widget for the application.
///
/// This widget sets up the MaterialApp and defines the routes for the app.
class MyApp extends StatelessWidget {
  /// Provider for sound settings, managing mute state.
  final SoundSettingsProvider soundSettingsProvider;

  /// Constructor for MyApp.
  ///
  /// Takes an [AudioPlayer] and [SoundSettingsProvider] as parameters.
  MyApp({required this.soundSettingsProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Sets the initial route of the application to be the LandingPage.
      initialRoute: LandingPage.routeName,

      /// Defines the routes and their corresponding widgets.
      ///
      /// Each route is mapped to a widget that should be displayed when
      /// the route is navigated to.
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