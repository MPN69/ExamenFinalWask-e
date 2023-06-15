import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waske_final_exam/firebase/services/providerServices.dart';
import 'package:waske_final_exam/views/Providers/addProviderPage.dart';
import 'package:waske_final_exam/views/Providers/editProviderPage.dart';
import 'package:waske_final_exam/views/Providers/providerViewPage.dart';
import 'package:waske_final_exam/widgets/loadingWidget.dart';

import '../../widgets/gameCardWidget.dart';

class ProviderListPage extends StatefulWidget {
  const ProviderListPage({super.key});

  @override
  State<ProviderListPage> createState() => _ProviderListPageState();
}

class _ProviderListPageState extends State<ProviderListPage> {
  Future<List<dynamic>> getProvidersList() async {
    final List<dynamic> providers = await getProviders();
    return providers;
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
        future: getProviders(),
        builder: (context, providers) {
          if (providers.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (providers.hasError) {
            return const Text('Error when loading Providers');
          } else {
            final providerList = providers.data!;
            return ListView.builder(
              itemCount: providerList.length,
              itemBuilder: (context, index) {
                final provider = providerList[index];
                return SizedBox(
                  height: 200,
                  child: GestureDetector(
                    onTap: () async {
                      final isSigned = await isSignedIn();
                      if (isSigned) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProviderPage(
                              idProvider: provider['idProveedor'].toString(),
                              developer: provider['Desarrollador'].toString(),
                              encharged: provider['Encargado'].toString(),
                              mail: provider['Correo'].toString(),
                              phone: provider['Telefono'].toString(),
                              uid: provider['uid'].toString(),
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProviderViewPage(
                              developer: provider["Desarrollador"],
                              encharged: provider["Encargado"],
                              mail: provider["Correo"],
                              phone: provider["Telefono"],
                            ),
                          ),
                        );
                      }
                    },
                    child: GameCardWidget(
                      gameTitle: provider["Desarrollador"],
                      gameImage: provider["Correo"],
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
                    builder: (context) => const AddProviderPage(),
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
