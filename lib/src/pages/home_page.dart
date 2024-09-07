import 'package:flutter/material.dart';
import 'package:tic_tac_toee/src/pages/widgets/tray_game.dart';
import 'package:tic_tac_toee/src/pages/widgets/type_house.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TrayGame trayGame = TrayGame();
  bool winner = false;
  bool gameOver = false;

  //Iniciar o primeiro upload da tela com as casas limpas
  String firstLoad(int index) {
    if (trayGame.cardHouse[index].name == "empty") {
      return "";
    } else {
      return trayGame.cardHouse[index].name;
    }
  }

  void clearHouse() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        trayGame.cardHouse[i] = TypeHouse.empty;
      }
      winner = false;
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //media query
    final height = MediaQuery.sizeOf(context).height * 0.1;
    final width = MediaQuery.sizeOf(context).width * 0.8;

    //Para verificar se há vencedor
    if (trayGame.checkWin) {
      winner = true;
    }

    // Para verificar se o jogo acabou
    if (!trayGame.cardHouse.contains(TypeHouse.empty) && winner != true) {
      gameOver = true;
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            //Titulo do Game
            "TIC TAC TOE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Jogador 01 \nX",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Jogador 02 \nO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Align(
              //Pra verificar a vez do jogador
              child: Text(
                "Agora é a vez do: ${trayGame.currentTurn == TypeHouse.O ? " X" : " O"}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              //Tabuleiro
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  //OnTap para definir o clique
                  onTap: () {
                    if (winner) {
                      //Se houver vencedor, não receberá valores
                      return;
                    }
                    if (trayGame.cardHouse[index] == TypeHouse.empty) {
                      //Para verificar se está "vazio", caso sim passa o turno e marca a casa
                      setState(() {
                        trayGame.passTurn();
                        trayGame.markHouse(index);
                      });
                    }
                  },
                  child: Card(
                    color: trayGame.winColor.contains(index.toString()) &&
                            winner == true
                        ? Colors.blue[900]
                        : Colors.grey[
                            900], //operador ternário que define a cor do vencedor
                    child: Center(
                      child: Text(
                        firstLoad(index),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            if (winner) //Para mostrar quem venceu
              Text(
                "O Vencedor é: ${trayGame.currentTurn == TypeHouse.X ? "X" : "O"}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            else if (gameOver)
              const Text(
                "Empate!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              const Text(
                " ",
                style: TextStyle(
                  color: Colors.transparent,
                  fontSize: 27,
                ),
              ),
            Container(
              //Para apagar os itens na tela
              color: Colors.transparent,
              height: height, //altura dinâmica
              width: width, //largura dinâmica
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: clearHouse,
                    icon: const Icon(
                      Icons.replay_outlined,
                      size: 55,
                    ),
                    label: const Text(
                      "RESTART",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
