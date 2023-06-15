//Crud de firebase
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseDatabase = FirebaseFirestore.instance;

//Client section----------------------------------------------------
Future<List> getClients() async {
  List clients = [];

  CollectionReference collectionOfGames =
      firebaseDatabase.collection('Clientes');
  QuerySnapshot queryGames = await collectionOfGames.get();

  queryGames.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final cliente = {
      "idCliente": data["idCliente"],
      "Nombre": data["Nombre"],
      "Apellido": data["Apellido"],
      "Genero": data["Genero"],
      "Correo": data["Correo"],
      "Imagen": data["Imagen"],
      "Telefono": data["Telefono"],
      "Password": data["Password"],
      "uid": doc.id,
    };
    clients.add(cliente);
  });

  return clients;
}

Future<String> getClientId(String clientName) async {
  String client = "";

  CollectionReference clientesReference =
      firebaseDatabase.collection("Clientes");
  QuerySnapshot queryClients = await clientesReference.get();

  bool foundClient = false;

  for (var cliente in queryClients.docs) {
    final dynamic data = cliente.data();
    if (data["Nombre"] == clientName) {
      client = data["idCliente"];
      foundClient = true;
      break;
    }
  }

  if (!foundClient) {
    print("No se encontró el cliente: $clientName");
  }

  return client;
}

Future<Map<String, dynamic>> getClientInfo(String clientName) async {
  Map<String, dynamic> clients = <String, dynamic>{};

  CollectionReference collectionOfClients =
      firebaseDatabase.collection("Clientes");
  QuerySnapshot queryClients = await collectionOfClients.get();

  queryClients.docs.forEach((client) {
    final dynamic data = client.data();
    if (data["Nombre"] == clientName) {
      clients = {
        "idCliente": data["idCliente"],
        "Nombre": data["Nombre"],
        "Apellido": data["Apellido"],
        "Genero": data["Genero"],
        "Correo": data["Correo"],
        "Imagen": data["Imagen"],
        "Telefono": data["Telefono"],
        "uid": client.id,
      };
    } else {
      clients = {
        "idCliente": "Juego no Encontrado",
        "Nombre": "Juego no Encontrado",
        "Apellido": "Juego no Encontrado",
        "Genero": "Juego no Encontrado",
        "Correo": "Juego no Encontrado",
        "Imagen": "Juego no Encontrado",
        "Telefono": "Juego no Encontrado",
        "uid": client.id,
      };
    }
  });
  return clients;
}

Future<bool> clientExistByMail(String mail) async {
  try {
    CollectionReference collectionOfClients =
        firebaseDatabase.collection("Clientes");
    var clientes =
        await collectionOfClients.where("Correo", isEqualTo: mail).get();
    print("no mms we ${clientes.size} alv");
    return clientes.size > 0;
  } catch (ex) {}

  return false;
}

Future<bool> addClient(
    String name,
    String lastName,
    String gender,
    String email,
    String image,
    String phone,
    String password,
    String id) async {
  try {
    await firebaseDatabase.collection("Clientes").doc(id).set({
      "Nombre": name,
      "Apellido": lastName,
      "Genero": gender,
      "Correo": email,
      "Imagen": image,
      "Telefono": phone,
      "Password": password,
      "idCliente": id,
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return false;
}

Future<void> updateClient(
    String uid,
    String name,
    String lastName,
    String gender,
    String email,
    String image,
    String phone,
    String password,
    String id) async {
  await firebaseDatabase.collection("Clientes").doc(uid).set({
    "Nombre": name,
    "Apellido": lastName,
    "Genero": gender,
    "Correo": email,
    "Imagen": image,
    "Telefono": phone,
    "Password": password,
    "idCliente": id,
  });
}

Future<void> deleteClient(String uid) async {
  await firebaseDatabase.collection("Clientes").doc(uid).delete();
}
