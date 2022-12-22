import 'package:flutter/cupertino.dart';

import '../../domain/entities/number_trivia.dart';

class TriviaWidget extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaWidget({
    Key? key,
    required this.numberTrivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Third of the size of the screen
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            numberTrivia.number.toString(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            child: Text(
              numberTrivia.text,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
