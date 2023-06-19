import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:examenfinalwask_e/views/Stores/addStorePage.dart';
import 'package:examenfinalwask_e/views/Stores/editStorePage.dart';
import 'package:examenfinalwask_e/views/Stores/storeViewPage.dart';

import '../../firebase/services/storeService.dart';
import '../../widgets/gameCardWidget.dart';
import '../../widgets/loadingWidget.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({Key? key}) : super(key: key);

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  Future<List<dynamic>> getStoreList() async {
    final List<dynamic> stores = await getStores();
    return stores;
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
        future: getStoreList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar las tiendas'),
            );
          } else {
            final storeList = snapshot.data!;
            return ListView.builder(
              itemCount: storeList.length,
              itemBuilder: (context, index) {
                final store = storeList[index];
                return GestureDetector(
                  onTap: () async {
                    final isSigned = await isSignedIn();
                    if (isSigned) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditStorePage(
                            id: store["idSucursal"].toString(),
                            name: store["Nombre"].toString(),
                            location: store["Ubicacion"].toString(),
                            image: store["Imagen"].toString(),
                            uid: store["uid"].toString(),
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreViewPage(
                            storeName: store["Nombre"],
                            storeImage: store["Imagen"],
                            storeLocation: store["Ubicacion"],
                          ),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    height: 120, // Ajusta la altura deseada de la tarjeta
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ), // Ajusta el espaciado vertical y horizontal entre las tarjetas
                      child: Row(
                        children: [
                          Container(
                            width: 120, // Ajusta el ancho deseado de la imagen
                            child: Image.network(
                              store["Imagen"],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    store["Nombre"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    store["Ubicacion"],
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                    builder: (context) => const AddStorePage(),
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
