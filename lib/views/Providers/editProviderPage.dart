import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/providerServices.dart';

class EditProviderPage extends StatefulWidget {
  final String idProvider;
  final String developer;
  final String encharged;
  final String mail;
  final String phone;
  final String uid;

  const EditProviderPage({
    Key? key,
    required this.idProvider,
    required this.developer,
    required this.encharged,
    required this.mail,
    required this.phone,
    required this.uid,
  }) : super(key: key);

  @override
  State<EditProviderPage> createState() => _EditProviderPageState();
}

class _EditProviderPageState extends State<EditProviderPage> {
  TextEditingController provider_developer = TextEditingController();
  TextEditingController provider_encharged = TextEditingController();
  TextEditingController provider_mail = TextEditingController();
  TextEditingController provider_phone = TextEditingController();
  TextEditingController provider_id = TextEditingController();
  String provider_uid = "";

  @override
  void initState() {
    super.initState();
    provider_id.text = widget.idProvider;
    provider_developer.text = widget.developer;
    provider_encharged.text = widget.encharged;
    provider_mail.text = widget.mail;
    provider_phone.text = widget.phone;
    provider_uid = widget.uid;
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
              await deleteProvider(provider_uid).then(
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
              controller: provider_id,
              decoration: const InputDecoration(
                hintText: "Game ID",
              ),
            ),
            TextField(
              controller: provider_developer,
              decoration: const InputDecoration(
                hintText: "Game Name",
              ),
            ),
            TextField(
              controller: provider_encharged,
              decoration: const InputDecoration(
                hintText: "Game Price",
              ),
            ),
            TextField(
              controller: provider_mail,
              decoration: const InputDecoration(
                hintText: "Game description",
              ),
            ),
            TextField(
              controller: provider_phone,
              decoration: const InputDecoration(
                hintText: "Game category",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateProvider(
                  provider_uid,
                  provider_developer.text,
                  provider_encharged.text,
                  provider_mail.text,
                  provider_phone.text,
                  provider_id.text,
                ).then((_) {
                  provider_id.text = "";
                  provider_developer.text = "";
                  provider_encharged.text = "";
                  provider_mail.text = "";
                  provider_phone.text = "";
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
