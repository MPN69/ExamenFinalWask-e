import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/gameService.dart';

class EditGamePage extends StatefulWidget {
  final String gameId;
  final String gameName;
  final String gamePrice;
  final String gameDescription;
  final String gameCategory;
  final String gameImage;
  final String uid;

  const EditGamePage({
    Key? key,
    required this.gameId,
    required this.gameName,
    required this.gamePrice,
    required this.gameDescription,
    required this.gameCategory,
    required this.gameImage,
    required this.uid,
  }) : super(key: key);

  @override
  State<EditGamePage> createState() => _EditGamePageState();
}

class _EditGamePageState extends State<EditGamePage> {
  TextEditingController game_name_controller = TextEditingController();
  TextEditingController game_price_controller = TextEditingController();
  TextEditingController game_description_controller = TextEditingController();
  TextEditingController game_category_controller = TextEditingController();
  TextEditingController game_image_controller = TextEditingController();
  TextEditingController game_id_controller = TextEditingController();
  String game_uid = "";

  @override
  void initState() {
    super.initState();
    game_id_controller.text = widget.gameId;
    game_name_controller.text = widget.gameName;
    game_price_controller.text = widget.gamePrice;
    game_description_controller.text = widget.gameDescription;
    game_category_controller.text = widget.gameCategory;
    game_image_controller.text = widget.gameImage;
    game_uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Game"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await deleteGame(game_uid).then(
                (_) => Navigator.pushNamed(context, '/'),
              );
            },
            style: TextButton.styleFrom(
              primary: Colors.white.withOpacity(0.3),
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: game_id_controller,
              decoration: const InputDecoration(
                hintText: "Game ID",
              ),
            ),
            TextField(
              controller: game_name_controller,
              decoration: const InputDecoration(
                hintText: "Game Name",
              ),
            ),
            TextField(
              controller: game_price_controller,
              decoration: const InputDecoration(
                hintText: "Game Price",
              ),
            ),
            TextField(
              controller: game_description_controller,
              decoration: const InputDecoration(
                hintText: "Game description",
              ),
            ),
            TextField(
              controller: game_category_controller,
              decoration: const InputDecoration(
                hintText: "Game category",
              ),
            ),
            TextField(
              controller: game_image_controller,
              decoration: const InputDecoration(
                hintText: "Game image",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateGame(
                  game_uid,
                  game_name_controller.text,
                  game_price_controller.text,
                  game_description_controller.text,
                  game_category_controller.text,
                  game_image_controller.text,
                  game_id_controller.text,
                ).then((_) {
                  game_name_controller.text = "";
                  game_price_controller.text = "";
                  game_description_controller.text = "";
                  game_category_controller.text = "";
                  game_id_controller.text = "";
                  Navigator.pushNamed(context, '/');
                });
              },
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
