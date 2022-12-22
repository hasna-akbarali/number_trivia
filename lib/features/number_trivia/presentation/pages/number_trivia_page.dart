import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../bloc/number_trivia_state.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NumberTrivia'),
      ),
      body: SingleChildScrollView(child: buildBlocProvider(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBlocProvider(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            //Top Half
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
              if (state is Empty) {
                return const MessageWidget(
                  message: 'Start Searching',
                );
              } else if (state is Loading) {
                return const LoadingWidget();
              } else if (state is Loaded) {
                return TriviaWidget(
                  numberTrivia: state.trivia,
                );
              } else if (state is Error) {
                return MessageWidget(
                  message: state.message,
                );
              } else {
                return Container();
              }
            }),
            const SizedBox(
              height: 20,
            ),
            //Bottom Half
            const TriviaControlWidget()
          ],
        ),
      ),
    );
  }
}
