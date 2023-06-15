import 'package:flutter/material.dart';

import '../../widgets/bottomNavbarWidget.dart';

class StoreViewPage extends StatelessWidget {
  final String storeName;
  final String storeImage;

  const StoreViewPage({
    Key? key,
    required this.storeName,
    required this.storeImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${storeName.toString()}"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => BottomNavbarWidget()),
              );
            },
            child: Text("volver"),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Text("${storeName}"),
          ),
          Center(
            child: Image(
              image: NetworkImage(
                storeImage.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
