import 'package:aflam/models/game.dart';
import 'package:aflam/models/providers.dart';
import 'package:aflam/screens/home_page.dart';
import 'package:aflam/screens/load_game_page.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:aflam/widgets/score_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: _EndScreenConsumer(),
      sheet: _BottomSheetConsumer(),
    );
  }
}

class _BottomSheetConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoadGamePage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff70e6bf),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Text(
                      'Play\nAgain',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xfffa3353),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      ref.read(pregameProvider.notifier).resetSettings();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ));
                    },
                    child: Text(
                      'End\nGame',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EndScreenConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Team winner = ref.read(gameProvider.notifier).findWinner();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              'WINNER IS',
              style: TextStyle(
                color: Color(0xfff3f9e2),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              winner.name,
              style: TextStyle(
                color: Color(0xff70e6bf),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Score Board',
              style: TextStyle(
                color: Color(0xfff3f9e2),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            child: ScoreBoard(),
          ),
        ),
        Container(
          height: 139,
        )
      ],
    );
  }
}
