import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:examenfinalwask_e/views/Games/addGamePage.dart';
import 'package:examenfinalwask_e/views/Games/editGamePage.dart';
import 'package:examenfinalwask_e/views/Games/gamesViewPage.dart';
import 'package:examenfinalwask_e/widgets/loadingWidget.dart';

import '../../firebase/services/gameService.dart';
import '../../widgets/gameCardWidget.dart';

class GameListPage extends StatefulWidget {
  const GameListPage({Key? key}) : super(key: key);

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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los juegos',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            );
          } else {
            final gameList = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: gameList.length,
              itemBuilder: (context, index) {
                final game = gameList[index];
                return GestureDetector(
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
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              game['Imagen'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            game['Nombre'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing:
                                  1.2, // Agregado: aumenta el espaciado entre letras
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
