///@file mtg_life_points_page.dart

import 'package:flutter/material.dart';
import 'common_drawer.dart';

/// MTGLifePointsPage is a stateful widget for tracking life points in a Magic: The Gathering game.
///
/// It allows each player to increment or decrement their life points and provides a visual display of the current points.
class MTGLifePointsPage extends StatefulWidget {
  static const String routeName = '/mtg_life_points'; // Define a route name

  @override
  _MTGLifePointsPageState createState() => _MTGLifePointsPageState();
}

class _MTGLifePointsPageState extends State<MTGLifePointsPage> {
  int player1LifePoints = 20; // Initial life points for Player 1
  int player2LifePoints = 20; // Initial life points for Player 2

  /// Controllers for text fields to edit player names.
  TextEditingController player1HeadingController = TextEditingController(text: 'Player 1');
  TextEditingController player2HeadingController = TextEditingController(text: 'Player 2');

  /// FocusNodes to manage focus on the text fields.
  FocusNode player1FocusNode = FocusNode();
  FocusNode player2FocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    /// Listeners to select all text in text field when focused.
    player1FocusNode.addListener(() {
      if (player1FocusNode.hasFocus) {
        player1HeadingController.selection = TextSelection(baseOffset: 0, extentOffset: player1HeadingController.text.length);
      }
    });
    player2FocusNode.addListener(() {
      if (player2FocusNode.hasFocus) {
        player2HeadingController.selection = TextSelection(baseOffset: 0, extentOffset: player2HeadingController.text.length);
      }
    });
  }

  /// Increments life points for Player 1.
  void incrementLifePointsPlayer1() {
    setState(() {
      player1LifePoints++;
    });
  }

  /// Decrements life points for Player 1.
  void decrementLifePointsPlayer1() {
    setState(() {
      player1LifePoints--;
    });
  }

  /// Increments life points for Player 2.
  void incrementLifePointsPlayer2() {
    setState(() {
      player2LifePoints++;
    });
  }

  /// Decrements life points for Player 2.
  void decrementLifePointsPlayer2() {
    setState(() {
      player2LifePoints--;
    });
  }

  @override
  void dispose() {
    /// Dispose controllers and focus nodes.
    player1HeadingController.dispose();
    player2HeadingController.dispose();
    player1FocusNode.dispose();
    player2FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDrawer(
      currentPage: MTGLifePointsPage.routeName,
      appBarSubtitle: 'MTG Life Points Counter',
      bodyContent: _buildMTGLifePointsBody(),
    );
  }

  /// Builds the main content of the MTGLifePointsPage.
  Widget _buildMTGLifePointsBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Spacer(),
          _buildLifePointsSection(player1HeadingController, player1LifePoints, incrementLifePointsPlayer1, decrementLifePointsPlayer1),
          SizedBox(height: 32),
          _buildLifePointsSection(player2HeadingController, player2LifePoints, incrementLifePointsPlayer2, decrementLifePointsPlayer2),
          Spacer(),
        ],
      ),
    );
  }

  /// Builds a section for managing the life points of a player.
  Widget _buildLifePointsSection(TextEditingController headingController, int lifePoints, Function increment, Function decrement) {
    return Column(
      children: <Widget>[
        TextFormField(
          maxLength: 10,
          controller: headingController,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => decrement(),
              child: Text('-'),
            ),
            Text(
              lifePoints.toString(),
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () => increment(),
              child: Text('+'),
            ),
          ],
        ),
      ],
    );
  }
}
