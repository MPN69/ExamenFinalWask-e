import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waske_final_exam/firebase/services/clientServices.dart';
import 'package:waske_final_exam/views/Clients/addClientPage.dart';
import 'package:waske_final_exam/views/Clients/clientViewPage.dart';
import 'package:waske_final_exam/views/Clients/editClientPage.dart';

import '../../widgets/gameCardWidget.dart';
import '../../widgets/loadingWidget.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({Key? key}) : super(key: key);

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  Future<List<dynamic>> getClientsList() async {
    final List<dynamic> clients = await getClients();
    return clients;
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
        future: getClientsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const Text('Error al cargar los juegos');
          } else {
            final clientList = snapshot.data!;
            return ListView.builder(
              itemCount: clientList.length,
              itemBuilder: (context, index) {
                final client = clientList[index];
                return SizedBox(
                  height: 200,
                  child: GestureDetector(
                    onTap: () async {
                      final isSigned = await isSignedIn();
                      if (isSigned) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditClientPage(
                              id: client["idCliente"].toString(),
                              name: client["Nombre"].toString(),
                              lastName: client["Apellido"].toString(),
                              gender: client["Genero"].toString(),
                              email: client["Correo"].toString(),
                              image: client["Imagen"].toString(),
                              phone: client["Telefono"].toString(),
                              password: client["Password"].toString(),
                              uid: client["uid"].toString(),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientViewPage(
                              clientName: client["Nombre"],
                              clientLastName: client["Apellido"],
                              clientGender: client["Genero"],
                              clientMail: client["Correo"],
                              clientImage: client["Imagen"],
                              clientPhone: client["Telefono"],
                            ),
                          ),
                        );
                      }
                    },
                    child: GameCardWidget(
                      gameTitle: client["Nombre"],
                      gameImage: client["Imagen"],
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
                    builder: (context) => const AddClientPage(),
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
