import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waske_final_exam/views/Stores/addStorePage.dart';
import 'package:waske_final_exam/views/Stores/editStorePage.dart';
import 'package:waske_final_exam/views/Stores/storeViewPage.dart';

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
    final List<dynamic> clients = await getStores();
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
        future: getStoreList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return const Text('Error while trying to load stores');
          } else {
            final StoreList = snapshot.data!;
            return ListView.builder(
              itemCount: StoreList.length,
              itemBuilder: (context, index) {
                final store = StoreList[index];
                return SizedBox(
                  height: 200,
                  child: GestureDetector(
                    onTap: () async {
                      final isSigned = await isSignedIn();
                      if (isSigned) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditStorePage(
                              id: store["idSucursal"].toString(),
                              name: store["Nombre"].toString(),
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
                            ),
                          ),
                        );
                      }
                    },
                    child: GameCardWidget(
                      gameTitle: store["Nombre"],
                      gameImage: store["Imagen"],
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
