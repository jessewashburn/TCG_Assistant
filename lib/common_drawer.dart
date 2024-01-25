///@file common_drawer.dart

import 'package:flutter/material.dart';
import 'dice_roller.dart';
import 'coin_flipper.dart';
import 'mtg_life_points_page.dart';
import 'yugioh_life_points_page.dart';
import 'landing_page.dart';
import 'settings_page.dart';

/// CommonDrawer is a reusable widget that provides a consistent layout with a navigation drawer and AppBar.
///
/// It is used across different pages of the app for uniformity in navigation and appearance.
class CommonDrawer extends StatelessWidget {
  /// The route name of the current page, used to highlight the current page in the drawer.
  final String currentPage;

  /// Subtitle to be displayed in the AppBar.
  final String appBarSubtitle;

  /// Main content of the page.
  final Widget bodyContent;

  /// Constructor for CommonDrawer.
  ///
  /// Requires [currentPage], [appBarSubtitle], and [bodyContent] as parameters.
  CommonDrawer({
    required this.currentPage,
    required this.appBarSubtitle,
    required this.bodyContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(appBarSubtitle),
        backgroundColor: Color(0xFFA6FFB8),
      ),
      drawer: _buildDrawer(context),
      body: bodyContent,
      backgroundColor: Colors.black,
    );
  }

  /// Builds the AppBar title widget.
  ///
  /// Includes the main title and the provided subtitle.
  Widget _buildAppBarTitle(String subtitle) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "TCG Assistant",
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
          ),
        ],
      ),
    );
  }

  /// Builds the navigation drawer for the app.
  ///
  /// Includes links to different pages and highlights the current page.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFA6FFB8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TCG Assistant",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Menu',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(context, 'Dice Roller', DicePage.routeName),
          _buildDrawerItem(context, 'Coin Flipper', CoinFlipper.routeName),
          _buildDrawerItem(context, 'MTG Life Points', MTGLifePointsPage.routeName),
          _buildDrawerItem(context, 'Yu-Gi-Oh Life Points', YugiohLifePointsPage.routeName),
          _buildDrawerItem(context, 'Settings', SettingsPage.routeName),
        ],
      ),
    );
  }

  /// Builds individual items for the drawer.
  ///
  /// Navigates to the specified route when tapped.
  Widget _buildDrawerItem(BuildContext context, String title, String routeName) {
    return ListTile(
      title: Text(title),
      onTap: () {
        if (currentPage != routeName) {
          Navigator.pushReplacementNamed(context, routeName);
        }
      },
    );
  }
}
