///@file settings_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sound_settings_provider.dart';
import 'common_drawer.dart';
import 'coin_flipper.dart';
import 'mtg_life_points_page.dart';
import 'yugioh_life_points_page.dart';

/// Represents the settings page of the application.
///
/// This stateless widget displays the settings related to the application,
/// specifically sound settings. It uses the Provider package for state management.
class SettingsPage extends StatelessWidget {
  /// The route name for navigation to this page.
  static const String routeName = '/settings_page';

  @override
  Widget build(BuildContext context) {
    /// Accessing the SoundSettingsProvider from the context.
    final soundSettingsProvider = Provider.of<SoundSettingsProvider>(context);

    /// Building the UI with a common drawer and specific body content.
    return CommonDrawer(
      currentPage: '/settings',
      appBarSubtitle: 'Settings',
      bodyContent: _buildSettingsPageBody(soundSettingsProvider),
    );
  }

  /// Builds the body content of the settings page.
  ///
  /// This method creates a container with a column of widgets including
  /// text and a switch to toggle sound settings.
  ///
  /// @param soundSettingsProvider The provider for sound settings.
  /// @return A widget representing the body of the settings page.
  Widget _buildSettingsPageBody(SoundSettingsProvider soundSettingsProvider) {
    return Container(
      color: Colors.black, // Set the background color to black
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sound Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ListTile(
            title: Text('Mute App', style: TextStyle(color: Colors.white)),
            trailing: Switch(
              value: soundSettingsProvider.isMuted, // Use the value from the provider
              onChanged: (value) {
                // Toggle mute state when the switch is toggled
                soundSettingsProvider.toggleMute();
              },
              activeColor: Colors.green, // Customize the switch color when active
            ),
          ),
        ],
      ),
    );
  }
}
