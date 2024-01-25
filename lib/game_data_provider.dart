import 'package:flutter/foundation.dart';

/// GameData is a class that manages the state of a game,
/// including life points and win counts for both Yu-Gi-Oh and Magic: The Gathering (MTG) games.
class GameData with ChangeNotifier {
  // Life points for Yu-Gi-Oh
  int player1LifePointsYuGiOh = 8000;
  int player2LifePointsYuGiOh = 8000;

  // Life points for MTG
  int player1LifePointsMTG = 20;
  int player2LifePointsMTG = 20;

  // Win counters for Yu-Gi-Oh
  int player1WinsYuGiOh = 0;
  int player2WinsYuGiOh = 0;

  // Win counters for MTG
  int player1WinsMTG = 0;
  int player2WinsMTG = 0;

  /// Adjusts the Yu-Gi-Oh life points for Player 1.
  void adjustYuGiOhLifePointsPlayer1(int value) {
    player1LifePointsYuGiOh += value;
    notifyListeners();
  }

  /// Adjusts the Yu-Gi-Oh life points for Player 2.
  void adjustYuGiOhLifePointsPlayer2(int value) {
    player2LifePointsYuGiOh += value;
    notifyListeners();
  }

  /// Adjusts the MTG life points for Player 1.
  void adjustMTGLifePointsPlayer1(int value) {
    player1LifePointsMTG += value;
    notifyListeners();
  }

  /// Adjusts the MTG life points for Player 2.
  void adjustMTGLifePointsPlayer2(int value) {
    player2LifePointsMTG += value;
    notifyListeners();
  }

  /// Increments the win count for Player 1 in Yu-Gi-Oh.
  void incrementWinsYuGiOhPlayer1() {
    player1WinsYuGiOh++;
    notifyListeners();

    if (player1WinsYuGiOh >= 2) {
      resetYuGiOhMatch();
    } else {
      resetYuGiOhLifePoints();
    }
  }

  /// Increments the win count for Player 2 in Yu-Gi-Oh.
  void incrementWinsYuGiOhPlayer2() {
    player2WinsYuGiOh++;
    notifyListeners();

    if (player2WinsYuGiOh >= 2) {
      resetYuGiOhMatch();
    } else {
      resetYuGiOhLifePoints();
    }
  }

  /// Increments the win count for Player 1 in MTG and resets the match if they reach 2 wins.
  void incrementWinsMTGPlayer1() {
    player1WinsMTG++;
    notifyListeners();

    if (player1WinsMTG >= 2) {
      resetMTGMatch();
    } else {
      resetMTGLifePoints();
    }
  }

  /// Increments the win count for Player 2 in MTG and resets the match if they reach 2 wins.
  void incrementWinsMTGPlayer2() {
    player2WinsMTG++;
    notifyListeners();

    if (player2WinsMTG >= 2) {
      resetMTGMatch();
    } else {
      resetMTGLifePoints();
    }
  }

  /// Resets the life points for both players in MTG back to the starting points.
  void resetMTGLifePoints() {
    player1LifePointsMTG = 20;
    player2LifePointsMTG = 20;
  }

  /// Resets the win counters for both players in MTG.
  void resetMTGMatch() {
    player1WinsMTG = 0;
    player2WinsMTG = 0;
    resetMTGLifePoints();
  }

  /// Resets the life points for both players in Yu-Gi-Oh back to the starting points.
  void resetYuGiOhLifePoints() {
    player1LifePointsYuGiOh = 8000;
    player2LifePointsYuGiOh = 8000;
  }

  /// Resets the win counters for both players in Yu-Gi-Oh.
  void resetYuGiOhMatch() {
    player1WinsYuGiOh = 0;
    player2WinsYuGiOh = 0;
    resetYuGiOhLifePoints();
  }
}
