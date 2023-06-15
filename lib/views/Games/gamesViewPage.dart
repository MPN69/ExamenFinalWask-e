import 'package:flutter/material.dart';
import 'package:waske_final_exam/widgets/bottomNavbarWidget.dart';

class GamesViewPage extends StatelessWidget {
  final String gameName;
  final String priceGame;
  final String gameDescription;
  final String gameCategory;
  final String gameImage;

  const GamesViewPage(
      {Key? key,
      required this.gameName,
      required this.priceGame,
      required this.gameDescription,
      required this.gameCategory,
      required this.gameImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${gameName.toString()}"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => BottomNavbarWidget()),
              );
            },
            child: Text("volver"),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Text("${gameDescription}"),
          ),
          Center(
            child: Text("${gameCategory}"),
          ),
          Center(
            child: Text("${priceGame}"),
          ),
          Center(
            child: Image(
              image: NetworkImage(
                gameImage.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
