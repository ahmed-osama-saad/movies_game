import 'package:aflam/constants/strings.dart';
import 'package:aflam/models/providers.dart';
import 'package:aflam/screens/turn_screen.dart';
import 'package:aflam/widgets/form_button.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartGameScreen extends ConsumerWidget {
  final List words;

  StartGameScreen(this.words);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(pregameProvider);
    final game = ref.watch(gameProvider);
    // watch(gameProvider.notifier).createGame(words);
    return MyScaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Text(
                'Get Ready',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xfff9f9e2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Text(
                '${game.teams.first.name}\'s',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: game.teams.first.color,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text(
                'Turn',
                style: TextStyle(
                  color: game.teams.first.color,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Text(
                settings.mode.startScreenText(game.teams.first.name),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xfff9f9e2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 130,
            )
          ],
        ),
      ),
      sheet: FormButton(
        callback: () {
          ref.read(gameProvider.notifier).createGame(words);
          ref.read(counterProvider.state).state = 0;
          ref.refresh(dimmerTimerProvider);
          ref.watch(dimmerTimerProvider.notifier).state.reset();
          ref.watch(dimmerProvider.notifier).state = false;
          // context.read(gameProvider.notifier).nextTurn();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TurnScreen()));
        },
        buttonColor: Color.fromARGB(255, 112, 230, 191),
        title: 'Start Game'.toUpperCase(),
        subtitle: 'Timer will start when you click.',
      ),
    );
  }
}
