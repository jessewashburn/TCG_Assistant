///@file sound_settings_provider

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the sound settings of the application.
///
/// This class handles the mute state of the application, providing
/// functionality to load, toggle, and persist the mute state using
/// shared preferences.
class SoundSettingsProvider with ChangeNotifier {

  // Indicates whether the sound is muted.
  bool _isMuted;

  /// Initializes [_isMuted] to false, indicating that sound is not muted
  /// by default when the application starts.
  SoundSettingsProvider() : _isMuted = false;

  /// Gets the current mute state.
  ///
  /// Returns `true` if the sound is currently muted, `false` otherwise.
  bool get isMuted => _isMuted;

  /// Loads the mute state from shared preferences.
  ///
  /// This method is typically called during application startup to
  /// initialize the mute state based on user's preferences saved
  /// in a previous session.
  ///
  /// Completes with void once the loading and setting of mute state
  /// is done.
  Future<void> loadMuteState() async {
    final prefs = await SharedPreferences.getInstance();
    _isMuted = prefs.getBool('isMuted') ?? false;
    notifyListeners();
  }

  /// Toggles the current mute state and saves the new state to shared preferences.
  ///
  /// This method inverts the current mute state (e.g., from muted to unmuted
  /// or vice versa) and persists this new state for future application sessions.
  ///
  /// Completes with void once the toggling and saving of the new mute state
  /// is done.
  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMuted', _isMuted);
    notifyListeners();
  }
}
