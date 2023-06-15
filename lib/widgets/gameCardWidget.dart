import 'package:flutter/material.dart';

class GameCardWidget extends StatelessWidget {
  final String gameTitle;
  final String gameImage;
  const GameCardWidget(
      {required this.gameTitle, required this.gameImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  gameImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              gameTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
