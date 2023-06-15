import 'package:flutter/material.dart';

import '../../firebase/services/storeService.dart';

class EditStorePage extends StatefulWidget {
  final String uid;
  final String name;
  final String image;
  final String id;

  const EditStorePage(
      {Key? key,
      required this.uid,
      required this.name,
      required this.image,
      required this.id})
      : super(key: key);

  @override
  State<EditStorePage> createState() => _EditStorePageState();
}

class _EditStorePageState extends State<EditStorePage> {
  TextEditingController store_name_controller = TextEditingController();
  TextEditingController store_image_controller = TextEditingController();
  TextEditingController store_id_controller = TextEditingController();
  String store_uid = "";

  @override
  void initState() {
    super.initState();
    store_name_controller.text = widget.name;
    store_image_controller.text = widget.image;
    store_id_controller.text = widget.id;
    store_uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Store"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await deleteStore(store_uid).then(
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
              controller: store_id_controller,
              decoration: const InputDecoration(
                hintText: "ID",
              ),
            ),
            TextField(
              controller: store_name_controller,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            TextField(
              controller: store_image_controller,
              decoration: const InputDecoration(
                hintText: "Profile Picture",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateStore(
                  store_uid,
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
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
