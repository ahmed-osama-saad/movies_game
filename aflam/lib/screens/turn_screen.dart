import 'package:aflam/models/providers.dart';
import 'package:aflam/screens/end_screen.dart';
import 'package:aflam/screens/score_screen.dart';
import 'package:aflam/widgets/game_widget.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock/wakelock.dart';

final counterProvider = StateProvider<int>((ref) {
  return 0;
});

final turnEndedProvider = StateProvider.autoDispose<bool>((ref) => false);

final skipsProvider = StateProvider<int>((ref) {
  final game = ref.watch(pregameProvider);
  return game.skips;
});

final dimmerProvider = StateProvider<bool>((ref) {
  return false;
});
final dimmerTimerProvider = StateProvider<RestartableTimer>((ref) {
  final dimmer = RestartableTimer(Duration(seconds: 10), () {
    ref.watch(dimmerProvider.notifier).state = true;
  });
  return dimmer;
});

class TurnScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Wakelock.enable();
    return MyScaffold(
      body: GameWidget(),
      sheet: _SheetConsumer(),
    );
  }
}

class _SheetConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _endTurn() {
      // context.read(gameProvider.notifier).submitAns(ans);
      // context.read(pregameProvider.notifier).nextTurn();
      // final turnEnded = watch(turnEndedProvider).state;
      // if (turnEnded) {}
      bool gameEnded = ref.watch(gameEndedProvider.state).state;
      if (gameEnded) {
        Wakelock.disable();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EndScreen(),
          ),
        );
      } else {
        Wakelock.disable();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreScreen(),
          ),
        );
      }
    }

    _answer(bool ans) {
      ref.read(gameProvider.notifier).submitAns(ans);
      final turnEnded = ref.read(turnEndedProvider.notifier).state;
      ref.watch(dimmerProvider.notifier).state = false;
      ref.read(dimmerTimerProvider.notifier).state.reset();
      if (ans) {
        if (turnEnded) {
          ref.watch(counterProvider.state).state++;
          _endTurn();
        } else {
          ref.read(gameProvider.notifier).nextWord(ref);
          ref.watch(counterProvider.state).state++;
          print('right' + ref.watch(counterProvider.state).state.toString());
        }
      } else {
        if (turnEnded) {
          _endTurn();
        } else {
          ref.watch(skipsProvider.notifier).state--;
          ref.read(gameProvider.notifier).nextWord(ref);
        }
      }
    }

    final skips = ref.watch(skipsProvider);
    print('skips $skips');
    final canSkip = skips > 0;

    return Container(
      height: 130,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 160,
                  height: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      _answer(true);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff70e6bf),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Text(
                      'Correct',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
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
                  child: canSkip
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xfffa3353),
                            padding: EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            _answer(false);
                          },
                          child: Text(
                            'Skip ($skips)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xfffa3353),
                            padding: EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            _answer(false);
                            _endTurn();
                          },
                          child: Text(
                            'Wrong',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
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
