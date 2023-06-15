import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waske_final_exam/firebase/services/clientServices.dart';

import 'gameService.dart';

FirebaseFirestore firebaseDatabase = FirebaseFirestore.instance;

//Fecha
//Precio
//idCliente
//idJuego
//idVenta
Future<List> getSales() async {
  List sales = [];

  CollectionReference CollectionOfSales = firebaseDatabase.collection('Venats');
  QuerySnapshot querySales = await CollectionOfSales.get();

  querySales.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final sale = {
      "Fecha": data["Fecha"],
      "Precio": data["Precio"],
      "idCliente": data["idCliente"],
      "idJuego": data["idJuego"],
      "idVenta": data["idVenta"],
      "uid": doc.id,
    };
    sales.add(sale);
  });
  return sales;
}

Future<bool> addSale(String fecha, String precio, String nombreCliente,
    String nombreJuego, String idVenta) async {
  try {
    String idCliente = await getClientId(nombreCliente);
    String idJuego = await getGameId(nombreJuego);

    await firebaseDatabase.collection("Venats").doc(idVenta).set({
      "Fecha": fecha,
      "Precio": precio,
      "idCliente": idCliente,
      "idJuego": idJuego,
      "idVenta": idVenta,
    });
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<void> updateSale(String uid, String fecha, String precio,
    String idCliente, String idJuego, String idVenta) async {
  await firebaseDatabase.collection("Venats").doc(uid).set({
    "Fecha": fecha,
    "Precio": precio,
    "idCliente": idCliente,
    "idJuego": idJuego,
    "idVenta": idVenta,
  });
}

Future<void> deleteSale(String uid) async {
  await firebaseDatabase.collection("Venats").doc(uid).delete();
}
