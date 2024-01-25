import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common_drawer.dart';
import 'game_data_provider.dart'; // Import the GameData provider

/// MTGLifePointsPage is a StatelessWidget that displays and manages the life points
/// for each player in a Magic: The Gathering game.
class MTGLifePointsPage extends StatelessWidget {
  static const String routeName = '/mtg_life_points';

  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameData>(context);

    return CommonDrawer(
      currentPage: MTGLifePointsPage.routeName,
      appBarSubtitle: 'MTG Life Point Counter',
      bodyContent: _buildMTGLifePointsBody(context, gameData),
    );
  }

  /// Builds the main body of the MTG life points page.
  Widget _buildMTGLifePointsBody(BuildContext context, GameData gameData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: _buildLifePointsSection(
            context,
            'Player 1',
            gameData.player1LifePointsMTG,
                () => gameData.adjustMTGLifePointsPlayer1(1),
                () => gameData.adjustMTGLifePointsPlayer1(-1),
            1,
            gameData,
          ),
        ),
        Expanded(
          child: _buildLifePointsSection(
            context,
            'Player 2',
            gameData.player2LifePointsMTG,
                () => gameData.adjustMTGLifePointsPlayer2(1),
                () => gameData.adjustMTGLifePointsPlayer2(-1),
            2,
            gameData,
          ),
        ),
      ],
    );
  }

  /// Creates a section of the UI for each player, displaying their name, life points, and buttons to adjust life points.
  Widget _buildLifePointsSection(BuildContext context, String playerName,
      int lifePoints, VoidCallback increment, VoidCallback decrement, int player,
      GameData gameData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          playerName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          lifePoints.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: decrement,
                  child: Text('-', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: increment,
                  child: Text('+', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            bool isWin =
                (player == 1 ? gameData.player1WinsMTG : gameData.player2WinsMTG) > index;
            return GestureDetector(
              onTap: () => _handleWinSelection(context, player, gameData),
              child: Container(
                margin: EdgeInsets.all(4),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isWin ? Colors.white : Colors.grey,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// Handles the selection of a win, incrementing the win count and checking if the match should be reset.
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
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;

    if (confirmEnd) {
      if (player == 1) {
        gameData.incrementWinsMTGPlayer1();
        if (gameData.player1WinsMTG >= 2) {
          // Delay the reset by 1 second to ensure the dialog closes
          Future.delayed(Duration(seconds: 1), () {
            gameData.resetMTGLifePoints(); // Reset the life points after recording the win
            gameData.resetMTGMatch(); // Reset the match after recording the win
          });
        }
      } else if (player == 2) {
        gameData.incrementWinsMTGPlayer2();
        if (gameData.player2WinsMTG >= 2) {
          // Delay the reset by 1 second to ensure the dialog closes
          Future.delayed(Duration(seconds: 1), () {
            gameData.resetMTGLifePoints(); // Reset the life points after recording the win
            gameData.resetMTGMatch(); // Reset the match after recording the win
          });
        }
      }
    }
  }
}
