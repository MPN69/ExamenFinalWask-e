//Crud de firebase
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseDatabase = FirebaseFirestore.instance;

//Client section----------------------------------------------------
Future<List> getProviders() async {
  List proveedores = [];

  CollectionReference collectionOfProveedores =
      firebaseDatabase.collection('Proveedor');
  QuerySnapshot queryProveedores = await collectionOfProveedores.get();

  queryProveedores.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final proveedor = {
      "idProveedor": data["idProveedor"],
      "Desarrollador": data["Desarrollador"],
      "Encargado": data["Encargado"],
      "Correo": data["Correo"],
      "Telefono": data["Telefono"],
      "uid": doc.id,
    };
    proveedores.add(proveedor);
  });

  return proveedores;
}

Future<Map<String, dynamic>> getProviderDeveloper(
    String providerDeveloper) async {
  Map<String, dynamic> provider = <String, dynamic>{};

  CollectionReference collectionOfProviders =
      firebaseDatabase.collection("Proveedor");
  QuerySnapshot queryProvider = await collectionOfProviders.get();

  queryProvider.docs.forEach((provider1) {
    final dynamic data = provider1.data();
    if (data["Nombre"] == providerDeveloper) {
      provider = {
        "idProveedor": data["idProveedor"],
        "Desarrollador": data["Desarrollador"],
        "Encargado": data["Encargado"],
        "Correo": data["Correo"],
        "Telefono": data["Telefono"],
        "uid": provider1.id,
      };
    } else {
      provider = {
        "idProveedor": "Provider not found",
        "Desarrollador": "Provider not found",
        "Encargado": "Provider not found",
        "Correo": "Provider not found",
        "Telefono": "Provider not found",
        "uid": provider1.id,
      };
    }
    print(provider1["Desarrollador"]);
  });
  return provider;
}

Future<bool> addProvider(String developer, String encharged, String mail,
    String phone, String id) async {
  try {
    await firebaseDatabase.collection("Proveedor").add({
      "Desarrollador": developer,
      "Encargado": encharged,
      "Correo": mail,
      "Telefono": phone,
      "idProveedor": id,
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return false;
}

Future<void> updateProvider(String uid, String developer, String encharged,
    String email, String phone, String id) async {
  await firebaseDatabase.collection("Proveedor").doc(uid).set({
    "Desarrollador": developer,
    "Encargado": encharged,
    "Correo": email,
    "Telefono": phone,
    "idProveedor": id,
  });
}

Future<void> deleteProvider(String uid) async {
  await firebaseDatabase.collection("Proveedor").doc(uid).delete();
}
