import 'package:flutter/material.dart';
import 'package:examenfinalwask_e/firebase/services/saleService.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({Key? key}) : super(key: key);

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  TextEditingController sale_date_controller = TextEditingController(text: "");
  TextEditingController sale_price_controller = TextEditingController(text: "");
  TextEditingController sale_idSale_controller =
      TextEditingController(text: "");
  TextEditingController sale_clientName_controller =
      TextEditingController(text: "");
  TextEditingController sale_gameName_controller =
      TextEditingController(text: "");

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
              controller: sale_date_controller,
              decoration: const InputDecoration(
                hintText: "Sale date",
              ),
            ),
            TextField(
              controller: sale_price_controller,
              decoration: const InputDecoration(
                hintText: "Sale price",
              ),
            ),
            TextField(
              controller: sale_idSale_controller,
              decoration: const InputDecoration(
                hintText: "Id Sale",
              ),
            ),
            TextField(
              controller: sale_clientName_controller,
              decoration: const InputDecoration(
                hintText: "Client name",
              ),
            ),
            TextField(
              controller: sale_gameName_controller,
              decoration: const InputDecoration(
                hintText: "Game name",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addSale(
                        sale_date_controller.text,
                        sale_price_controller.text,
                        sale_clientName_controller.text,
                        sale_gameName_controller.text,
                        sale_idSale_controller.text)
                    .then((_) {
                  sale_date_controller.text = "";
                  sale_price_controller.text = "";
                  sale_clientName_controller.text = "";
                  sale_gameName_controller.text = "";
                  sale_idSale_controller.text = "";
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
