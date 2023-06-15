import 'package:flutter/material.dart';
import 'package:waske_final_exam/firebase/services/gameService.dart';
import 'package:waske_final_exam/widgets/loadingWidget.dart';

class GetByNameTest extends StatefulWidget {
  const GetByNameTest({Key? key}) : super(key: key);

  @override
  State<GetByNameTest> createState() => _GetByNameTestState();
}

class _GetByNameTestState extends State<GetByNameTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("By Name"),
        titleTextStyle: TextStyle(fontSize: 20),
      ),
      body: FutureBuilder(
        future: getGameInfo("JuegoA"),
        builder: (context, gameInfo) {
          if (gameInfo.hasData) {
            // return ListView.builder(
            //   itemBuilder: (context, index) {
            return Text(gameInfo.data?["Nombre"]);
            //   },
            // );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
