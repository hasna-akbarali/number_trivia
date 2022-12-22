import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

const purple = Color(0xFFB1AFFF);

class TriviaControlWidget extends StatefulWidget {
  const TriviaControlWidget({Key? key}) : super(key: key);

  @override
  State<TriviaControlWidget> createState() => _TriviaControlWidgetState();
}

class _TriviaControlWidgetState extends State<TriviaControlWidget> {
  late String inputStr;
  final controller = TextEditingController();

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TextField
        TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              // only accept letters from 0 to 9
              FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true)
              // Using for Text Only ==>    (RegExp(r'[a-zA-Z]'))
            ],
            decoration: const InputDecoration(
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: purple)),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: purple)),
                border: OutlineInputBorder(),
                hintText: 'Input A Number'),
            onChanged: (value) {
              inputStr = value;
            }),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              // Search concrete button
              child: ElevatedButton(
                onPressed: () {
                  dispatchConcrete();
                },
                child: Text(
                  'Search',
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFB1AFFF))),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              // Search concrete button
              child: ElevatedButton(
                onPressed: () {
                  dispatchRandom();
                },
                child: Text(
                  'Get Random Number',
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFB1AFFF))),
              ),
            ),
          ],
        )
      ],
    );
  }
}
