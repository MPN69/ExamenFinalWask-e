import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waske_final_exam/views/Games/addGamePage.dart';
import 'package:waske_final_exam/views/Games/editGamePage.dart';
import 'package:waske_final_exam/views/Games/gamesViewPage.dart';
import 'package:waske_final_exam/widgets/loadingWidget.dart';

import '../../firebase/services/gameService.dart';
import '../../widgets/gameCardWidget.dart';

class GameListPage extends StatefulWidget {
  const GameListPage({super.key});

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  Future<List<dynamic>> getGamesList() async {
    final List<dynamic> games = await getGames();
    return games;
  }

  Future<bool> isSignedIn() async {
    GoogleSignIn signIn = GoogleSignIn();
    bool isSignedIn = await signIn.isSignedIn();
    return isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: getGamesList(),
        builder: (context, games) {
          if (games.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (games.hasError) {
            return const Text('Error al cargar los juegos');
          } else {
            final gameList = games.data!;
            return ListView.builder(
              itemCount: gameList.length,
              itemBuilder: (context, index) {
                final game = gameList[index];
                return SizedBox(
                  height: 200,
                  child: GestureDetector(
                    onTap: () async {
                      final isSigned = await isSignedIn();
                      if (isSigned) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditGamePage(
                              gameId: game['idJuego'].toString(),
                              gameName: game['Nombre'].toString(),
                              gamePrice: game['Precio'].toString(),
                              gameDescription: game['Descripcion'].toString(),
                              gameCategory: game['Categoria'].toString(),
                              gameImage: game['Imagen'].toString(),
                              uid: game['uid'].toString(),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamesViewPage(
                              gameName: game['Nombre'].toString(),
                              priceGame: game['Precio'].toString(),
                              gameDescription: game['Descripcion'].toString(),
                              gameCategory: game['Categoria'].toString(),
                              gameImage: game['Imagen'].toString(),
                            ),
                          ),
                        );
                      }
                    },
                    child: GameCardWidget(
                      gameTitle: game["Nombre"],
                      gameImage: game["Imagen"],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FutureBuilder<bool>(
        future: isSignedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddGamePage(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
