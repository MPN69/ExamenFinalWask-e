import 'package:flutter/material.dart';
import 'package:examenfinalwask_e/firebase/services/saleService.dart';

class EditSalePage extends StatefulWidget {
  final String fecha;
  final String precio;
  final String idSale;
  final String idClient;
  final String idGame;
  final String uid;

  const EditSalePage({
    Key? key,
    required this.fecha,
    required this.precio,
    required this.idSale,
    required this.idClient,
    required this.idGame,
    required this.uid,
  }) : super(key: key);

  @override
  State<EditSalePage> createState() => _EditSalePageState();
}

class _EditSalePageState extends State<EditSalePage> {
  TextEditingController sale_price = TextEditingController();
  TextEditingController id_Sale = TextEditingController();
  TextEditingController id_Client = TextEditingController();
  TextEditingController id_game = TextEditingController();
  TextEditingController provider_id = TextEditingController();
  String sale_uid = "";

  @override
  void initState() {
    super.initState();
    provider_id.text = widget.fecha;
    sale_price.text = widget.precio;
    id_Sale.text = widget.idSale;
    id_Client.text = widget.idClient;
    id_game.text = widget.idGame;
    sale_uid = widget.uid;
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
              await deleteSale(sale_uid).then(
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
                hintText: "Provider id",
              ),
            ),
            TextField(
              controller: sale_price,
              decoration: const InputDecoration(
                hintText: "Sale Price",
              ),
            ),
            TextField(
              controller: id_Sale,
              decoration: const InputDecoration(
                hintText: "Id Sale",
              ),
            ),
            TextField(
              controller: id_Client,
              decoration: const InputDecoration(
                hintText: "Id Client",
              ),
            ),
            TextField(
              controller: id_game,
              decoration: const InputDecoration(
                hintText: "Id Game",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateSale(
                  sale_uid,
                  sale_price.text,
                  id_Sale.text,
                  id_Client.text,
                  id_game.text,
                  provider_id.text,
                ).then((_) {
                  provider_id.text = "";
                  sale_price.text = "";
                  id_Sale.text = "";
                  id_Client.text = "";
                  id_game.text = "";
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
