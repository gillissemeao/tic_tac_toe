import 'package:tic_tac_toee/src/pages/widgets/type_house.dart';

class TrayGame {
  var cardHouse = List<TypeHouse>.filled(9, TypeHouse.empty);
  var currentTurn = TypeHouse.X;
  String winColor = "";

  //marcar a cardHouse
  void markHouse(int index) {
    cardHouse[index] = currentTurn;
  }

  //passar a vez para o outro jogador
  void passTurn() {
    currentTurn = currentTurn == TypeHouse.X ? TypeHouse.O : TypeHouse.X;
  }

  //verificar se o jogador ganhou
  bool get checkWin {
    List<String> winHouses = [
      '012',
      '345',
      '678',
      '036',
      '147',
      '258',
      '048',
      '246'
    ]; //posições possíveis para vencer

    for (var winElement in winHouses) {
      //ler por elemento da lista acima
      var char1 = int.parse(winElement[0]);
      var char2 = int.parse(winElement[1]);
      var char3 = int.parse(winElement[2]);

      //ler por caractere da lista acima
      if (cardHouse[char1] == cardHouse[char2] &&
          cardHouse[char3] == cardHouse[char2] &&
          cardHouse[char2] == currentTurn) {
        winColor = winElement;
        return true;
      }
    }
    return false;
  }
}
