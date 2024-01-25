import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common_drawer.dart';
import 'game_data_provider.dart'; // Import the GameData provider

/// YugiohLifePointsPage is a StatelessWidget that displays the life points
/// for each player in a Yu-Gi-Oh game and allows adjusting them.
class YugiohLifePointsPage extends StatelessWidget {
  static const String routeName = '/yugioh_life_points';

  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameData>(context);

    return CommonDrawer(
      currentPage: YugiohLifePointsPage.routeName,
      appBarSubtitle: 'Yu-gi-Oh Life Point Counter',
      bodyContent: _buildYugiohLifePointsBody(context, gameData),
    );
  }

  /// Builds the body of the Yu-Gi-Oh life points page.
  Widget _buildYugiohLifePointsBody(BuildContext context, GameData gameData) {
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
                  _buildPlayerSection('Player 1', gameData.player1LifePointsYuGiOh, (value) => gameData.adjustYuGiOhLifePointsPlayer1(value), 1, gameData, context),
                  SizedBox(height: 32), // Space between player sections
                  _buildPlayerSection('Player 2', gameData.player2LifePointsYuGiOh, (value) => gameData.adjustYuGiOhLifePointsPlayer2(value), 2, gameData, context),
                  Expanded(child: Container()), // Spacer at the bottom
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds a section of the UI for each player, displaying their name, life points, and buttons to adjust life points.
  Widget _buildPlayerSection(String playerName, int lifePoints, Function(int) adjustLife, int player, GameData gameData, BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          playerName,
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
            Text(
              lifePoints.toString(),
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Column(
              children: <Widget>[
                _buildLifePointButton(50, adjustLife),
                _buildLifePointButton(100, adjustLife),
                _buildLifePointButton(1000, adjustLife),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            bool isWin = (player == 1 ? gameData.player1WinsYuGiOh : gameData.player2WinsYuGiOh) > index;
            return GestureDetector(
              onTap: () => _handleWinSelection(context, player, gameData),
              child: Container(
                margin: EdgeInsets.all(4),
                width: 30,
                height: 30,
                decoration: BoxDecoration(shape: BoxShape.circle, color: isWin ? Colors.white : Colors.grey),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// Creates a button to adjust life points by a specific amount.
  Widget _buildLifePointButton(int amount, Function(int) adjustLife) {
    return ElevatedButton(
      onPressed: () => adjustLife(amount),
      child: Text(amount >= 0 ? '+$amount' : '$amount'),
    );
  }

  /// Handles the selection of a win, incrementing the win count.
  Future<void> _handleWinSelection(BuildContext context, int player, GameData gameData) async {
    bool confirmEnd = await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('End Game?'),
          content: Text('Do you want to record this win?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    ) ?? false;

    if (confirmEnd) {
      if (player == 1) {
        gameData.incrementWinsYuGiOhPlayer1();
      } else if (player == 2) {
        gameData.incrementWinsYuGiOhPlayer2();
      }
    }
  }
}
