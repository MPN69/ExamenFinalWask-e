import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/providerServices.dart';

class AddProviderPage extends StatefulWidget {
  const AddProviderPage({Key? key}) : super(key: key);

  @override
  State<AddProviderPage> createState() => _AddProviderPageState();
}

class _AddProviderPageState extends State<AddProviderPage> {
  TextEditingController provider_Email = TextEditingController(text: "");
  TextEditingController provider_Developer = TextEditingController(text: "");
  TextEditingController provider_Encharged = TextEditingController(text: "");
  TextEditingController provider_Phone = TextEditingController(text: "");
  TextEditingController provider_id = TextEditingController(text: "");

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
              controller: provider_id,
              decoration: const InputDecoration(
                hintText: "Game ID",
              ),
            ),
            TextField(
              controller: provider_Developer,
              decoration: const InputDecoration(
                hintText: "Game Name",
              ),
            ),
            TextField(
              controller: provider_Encharged,
              decoration: const InputDecoration(
                hintText: "Game Price",
              ),
            ),
            TextField(
              controller: provider_Email,
              decoration: const InputDecoration(
                hintText: "Game description",
              ),
            ),
            TextField(
              controller: provider_Phone,
              decoration: const InputDecoration(
                hintText: "Game category",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addProvider(
                        provider_Developer.text,
                        provider_Encharged.text,
                        provider_Email.text,
                        provider_Phone.text,
                        provider_id.text)
                    .then((_) {
                  provider_Developer.text = "";
                  provider_Encharged.text = "";
                  provider_Email.text = "";
                  provider_Phone.text = "";
                  provider_id.text = "";
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
