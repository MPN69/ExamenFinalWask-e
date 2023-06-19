import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:examenfinalwask_e/firebase/services/saleService.dart';
import 'package:examenfinalwask_e/views/Sales/addSalePage.dart';
import 'package:examenfinalwask_e/views/Sales/editSalePage.dart';
import 'package:examenfinalwask_e/views/Sales/saleViewPage.dart';
import 'package:examenfinalwask_e/widgets/loadingWidget.dart';

import '../../widgets/gameCardWidget.dart';

class SaleListPage extends StatefulWidget {
  const SaleListPage({super.key});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  Future<List<dynamic>> getSalesList() async {
    final List<dynamic> sales = await getSales();
    return sales;
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
        future: getSales(),
        builder: (context, sales) {
          if (sales.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (sales.hasError) {
            return const Text('Error when loading Sales');
          } else {
            final salesList = sales.data!;
            return ListView.builder(
              itemCount: salesList.length,
              itemBuilder: (context, index) {
                final sale = salesList[index];
                return SizedBox(
                  height: 200,
                  child: GestureDetector(
                    onTap: () async {
                      final isSigned = await isSignedIn();
                      if (isSigned) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditSalePage(
                              precio: sale['Precio'].toString(),
                              fecha: sale['Fecha'].toString(),
                              idSale: sale['idVenta'].toString(),
                              idClient: sale['idCliente'].toString(),
                              idGame: sale['idJuego'].toString(),
                              uid: sale['uid'].toString(),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaleViewPage(
                              precio: sale['Precio'].toString(),
                              fecha: sale['Fecha'].toString(),
                              idCliente: sale['idCliente'].toString(),
                              idJuego: sale['idJuego'].toString(),
                            ),
                          ),
                        );
                      }
                    },
                    child: GameCardWidget(
                      gameTitle: sale["Precio"],
                      gameImage: sale["Fecha"],
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
                    builder: (context) => const AddSalePage(),
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
