import 'package:flutter/material.dart';
import 'package:examenfinalwask_e/widgets/bottomNavbarWidget.dart';

class SaleViewPage extends StatelessWidget {
  final String precio;
  final String fecha;
  final String idCliente;
  final String idJuego;

  const SaleViewPage({
    Key? key,
    required this.precio,
    required this.fecha,
    required this.idCliente,
    required this.idJuego,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${precio.toString()}"),
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
            child: Text("${fecha}"),
          ),
          Center(
            child: Text("${idCliente}"),
          ),
          Center(
            child: Text("${idJuego}"),
          ),
        ],
      ),
    );
  }
}
