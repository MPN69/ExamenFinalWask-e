import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:examenfinalwask_e/firebase/services/clientServices.dart';
import 'package:examenfinalwask_e/views/Clients/addClientPage.dart';
import 'package:examenfinalwask_e/views/Clients/clientViewPage.dart';
import 'package:examenfinalwask_e/views/Clients/editClientPage.dart';

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
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 4),
              itemCount: clientList.length,
              itemBuilder: (context, index) {
                final client = clientList[index];
                return GestureDetector(
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
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0, // Ajusta los espacios verticales
                        horizontal: 16.0,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(client["Imagen"]),
                          radius:
                              30, // Ajusta el tamaño de la imagen del avatar
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              client["Nombre"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              client["Apellido"],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'Género: ${client["Genero"]}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
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
