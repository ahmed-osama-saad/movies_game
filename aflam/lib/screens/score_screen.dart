import 'package:aflam/models/providers.dart';
import 'package:aflam/models/game.dart';
import 'package:aflam/screens/turn_screen.dart';
import 'package:aflam/widgets/form_button.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:aflam/widgets/score_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreScreen extends StatelessWidget {
  ScoreScreen();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: _ScoreScreenConsumer(),
      sheet: _BottomSheetConsumer(),
    );
  }
}

class _BottomSheetConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Game game = ref.watch(gameProvider);
    return FormButton(
      callback: () {
        ref.read(gameProvider.notifier).nextTurn();
        ref.watch(counterProvider.state).state = 0;
        ref.watch(turnEndedProvider.state).state = false;
        ref.refresh(skipsProvider);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TurnScreen(),
          ),
        );
        // }
      },
      buttonColor: Color.fromARGB(255, 112, 230, 191),
      title: 'Next ${game.teams[game.nextTeam].name}',
      subtitle:
          'please give the phone to ${game.teams[game.nextTeam].name} \nbefore clicking next',
    );
  }
}

class _ScoreScreenConsumer extends ConsumerWidget {
  _ScoreScreenConsumer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Game game = ref.watch(gameProvider);
    final counter = ref.watch(counterProvider.state).state;
    final bool ans = counter > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              ans
                  ? '${game.teams[game.currentTeam].name} WINS'
                  : '${game.teams[game.currentTeam].name} LOSE',
              style: TextStyle(
                color: Color(0xfff8f7df),
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              ans
                  ? '+${ref.watch(counterProvider.state).state.toString()} points'
                  : 'no points',
              style: TextStyle(
                color: Color(0xff70e6bf),
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              'please give the phone to ${game.teams[game.nextTeam].name}',
              style: TextStyle(
                color: Color(0xffe7e7e6),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              'Score board',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ScoreBoard(),
          ),
        ),
        Container(
          height: 139,
        ),
      ],
    );
  }
}
