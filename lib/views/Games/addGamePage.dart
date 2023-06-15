import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/gameService.dart';

class AddGamePage extends StatefulWidget {
  const AddGamePage({Key? key}) : super(key: key);

  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  TextEditingController game_name_controller = TextEditingController(text: "");
  TextEditingController game_price_controller = TextEditingController(text: "");
  TextEditingController game_description_controller =
      TextEditingController(text: "");
  TextEditingController game_category_controller =
      TextEditingController(text: "");
  TextEditingController game_id_controller = TextEditingController(text: "");
  TextEditingController game_image_controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Game"),
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
                hintText: "Game Image",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addGame(
                        game_name_controller.text,
                        game_price_controller.text,
                        game_description_controller.text,
                        game_category_controller.text,
                        game_image_controller.text,
                        game_id_controller.text)
                    .then((_) {
                  game_name_controller.text = "";
                  game_price_controller.text = "";
                  game_description_controller.text = "";
                  game_category_controller.text = "";
                  game_image_controller.text = "";
                  game_id_controller.text = "";
                  Navigator.pushNamed(context, '/');
                });
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
