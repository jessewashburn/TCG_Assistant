///@file yugioh_life_points_page.dart

import 'package:flutter/material.dart';
import 'common_drawer.dart';
import 'coin_flipper.dart';
import 'mtg_life_points_page.dart';

/// YugiohLifePointsPage is a stateful widget for tracking life points in a Yu-Gi-Oh! game.
///
/// It allows each player to adjust their life points and provides a visual display of the current points.
class YugiohLifePointsPage extends StatefulWidget {
  static const String routeName = '/yugioh_life_points';

  @override
  _YugiohLifePointsPageState createState() => _YugiohLifePointsPageState();
}

class _YugiohLifePointsPageState extends State<YugiohLifePointsPage> {
  int player1LifePoints = 8000; // Initial life points for Player 1
  int player2LifePoints = 8000; // Initial life points for Player 2

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

  /// Adjusts life points for Player 1.
  void adjustLifePointsPlayer1(int value) {
    setState(() {
      player1LifePoints += value;
    });
  }

  /// Adjusts life points for Player 2.
  void adjustLifePointsPlayer2(int value) {
    setState(() {
      player2LifePoints += value;
    });
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes.
    player1HeadingController.dispose();
    player2HeadingController.dispose();
    player1FocusNode.dispose();
    player2FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDrawer(
      currentPage: YugiohLifePointsPage.routeName,
      appBarSubtitle: 'Yu-gi-Oh Life Point Counter',
      bodyContent: _buildYugiohLifePointsBody(),
    );
  }

  /// Builds the main content of the YugiohLifePointsPage.
  Widget _buildYugiohLifePointsBody() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: Container()), // Spacer at the top
                  _buildPlayerSection(player1HeadingController, player1FocusNode, player1LifePoints, adjustLifePointsPlayer1),
                  SizedBox(height: 32), // Space between player sections
                  _buildPlayerSection(player2HeadingController, player2FocusNode, player2LifePoints, adjustLifePointsPlayer2),
                  Expanded(child: Container()), // Spacer at the bottom
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds a section for managing the life points of a player.
  Widget _buildPlayerSection(TextEditingController headingController, FocusNode focusNode, int lifePoints, Function(int) adjustLife) {
    return Column(
      children: <Widget>[
        TextFormField(
          maxLength: 10,
          controller: headingController,
          focusNode: focusNode,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildLifePointButton(-50, adjustLife),
                _buildLifePointButton(-100, adjustLife),
                _buildLifePointButton(-1000, adjustLife),
              ],
            ),
            Text(lifePoints.toString(), style: TextStyle(fontSize: 24, color: Colors.white)),
            Column(
              children: <Widget>[
                _buildLifePointButton(50, adjustLife),
                _buildLifePointButton(100, adjustLife),
                _buildLifePointButton(1000, adjustLife),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a button for adjusting life points by a specific amount.
  Widget _buildLifePointButton(int amount, Function(int) adjustLife) {
    return ElevatedButton(
      onPressed: () => adjustLife(amount),
      child: Text(amount >= 0 ? '+$amount' : '$amount'),
    );
  }
}
