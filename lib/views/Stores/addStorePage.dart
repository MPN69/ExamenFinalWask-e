import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/storeService.dart';

class AddStorePage extends StatefulWidget {
  const AddStorePage({Key? key}) : super(key: key);

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  TextEditingController store_name_controller = TextEditingController(text: "");
  TextEditingController store_image_controller =
      TextEditingController(text: "");
  TextEditingController store_id_controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Client"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: store_name_controller,
              decoration: const InputDecoration(
                hintText: "Store Name",
              ),
            ),
            TextField(
              controller: store_id_controller,
              decoration: const InputDecoration(
                hintText: "Store ID",
              ),
            ),
            TextField(
              controller: store_image_controller,
              decoration: const InputDecoration(
                hintText: "Store image",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addStore(
                  store_name_controller.text,
                  store_image_controller.text,
                  store_id_controller.text,
                ).then((_) {
                  store_name_controller.text = "";
                  store_image_controller.text = "";
                  store_id_controller.text = "";
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
