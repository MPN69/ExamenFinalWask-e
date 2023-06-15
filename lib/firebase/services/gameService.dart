//Crud de firebase
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseDatabase = FirebaseFirestore.instance;

//Es una promesa de lo que nos va a mandar la BD
Future<List> getGames() async {
  List games = [];

  CollectionReference collectionOfGames = firebaseDatabase.collection('Juegos');
  QuerySnapshot queryGames = await collectionOfGames.get();

  queryGames.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final game = {
      "idJuego": data["idJuego"],
      "Nombre": data["Nombre"],
      "Categoria": data["Categoria"],
      "Descripcion": data["Descripcion"],
      "Precio": data["Precio"],
      "Imagen": data["Imagen"],
      "uid": doc.id,
    };
    games.add(game);
  });

  return games;
}

Future<String> getGameId(String gameName) async {
  String game = "";

  CollectionReference gameReference = firebaseDatabase.collection("Juegos");
  QuerySnapshot queryGames = await gameReference.get();

  for (var games in queryGames.docs) {
    final dynamic data = games.data();
    if (data["Nombre"] == gameName) {
      game = data["idJuego"];
      break;
    }
  }

  return game;
}

Future<Map<String, dynamic>> getGameInfo(String gameName) async {
  Map<String, dynamic> games = <String, dynamic>{};

  CollectionReference collectionOfGames = firebaseDatabase.collection("Juegos");
  QuerySnapshot queryGames = await collectionOfGames.get();

  queryGames.docs.forEach((game) {
    final dynamic data = game.data();
    if (data["Nombre"] == gameName) {
      games = {
        "idJuego": data["idJuego"],
        "Nombre": data["Nombre"],
        "Categoria": data["Categoria"],
        "Descripcion": data["Descripcion"],
        "Precio": data["Precio"],
        "Imagen": data["Imagen"],
        "uid": game.id,
      };
    } else {
      games = {
        "idJuego": "Juego no Encontrado",
        "Nombre": "Juego no Encontrado",
        "Categoria": "Juego no Encontrado",
        "Descripcion": "Juego no Encontrado",
        "Precio": "Juego no Encontrado",
        "uid": game.id,
      };
    }
    print(game["Nombre"]);
  });
  return games;
}

Future<bool> addGame(String name, String price, String description,
    String category, String image, String id) async {
  try {
    await firebaseDatabase.collection("Juegos").add({
      "Nombre": name,
      "Precio": price,
      "Descripcion": description,
      "Categoria": category,
      "idJuego": id,
      "Imagen": image
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return false;
}

Future<void> updateGame(String uid, String name, String price,
    String description, String category, String image, String id) async {
  await firebaseDatabase.collection("Juegos").doc(uid).set({
    "Nombre": name,
    "Precio": price,
    "Descripcion": description,
    "Categoria": category,
    "idJuego": id,
    "Imagen": image
  });
}

Future<void> deleteGame(String uid) async {
  await firebaseDatabase.collection("Juegos").doc(uid).delete();
}
