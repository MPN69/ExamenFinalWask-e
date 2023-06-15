//Crud de firebase
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseDatabase = FirebaseFirestore.instance;

//Client section----------------------------------------------------
Future<List> getStores() async {
  List sucursals = [];

  CollectionReference collectionOfSucursals =
      firebaseDatabase.collection('Sucursales');
  QuerySnapshot querySucursals = await collectionOfSucursals.get();

  querySucursals.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final sucursal = {
      "idSucursal": data["idSucursal"],
      "Nombre": data["Nombre"],
      "Imagen": data["Imagen"],
      "uid": doc.id,
    };
    sucursals.add(sucursal);
  });

  return sucursals;
}

Future<String> getStoreId(String storeName) async {
  String store = "";

  CollectionReference sucursalesReference =
      firebaseDatabase.collection("Sucursales");
  QuerySnapshot querySucursals = await sucursalesReference.get();

  querySucursals.docs.forEach((sucursal) {
    final dynamic data = sucursal.data();
    if (data["Nombre"] == storeName) {
      sucursal = data["idSucursal"];
    }
  });
  return store;
}

Future<bool> addStore(String name, String image, String id) async {
  try {
    await firebaseDatabase.collection("Sucursales").doc(id).set({
      "Nombre": name,
      "Imagen": image,
      "idSucursal": id,
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return false;
}

Future<void> updateStore(
    String uid, String name, String image, String id) async {
  await firebaseDatabase.collection("Sucursales").doc(uid).set({
    "Nombre": name,
    "Imagen": image,
    "idSucursal": id,
  });
}

Future<void> deleteStore(String uid) async {
  await firebaseDatabase.collection("Sucursales").doc(uid).delete();
}
