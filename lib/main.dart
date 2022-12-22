import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as ic;

const purple = Color(0xFFB1AFFF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NumberTrivia',
        theme: ThemeData(
            primaryColor: purple,
            appBarTheme: const AppBarTheme(
              color: purple,
            )),
        home: const NumberTriviaPage());
  }
}
