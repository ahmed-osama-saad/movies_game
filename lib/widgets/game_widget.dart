import 'package:aflam/constants/strings.dart';
import 'package:aflam/models/providers.dart';
import 'package:aflam/models/game.dart';
import 'package:aflam/screens/score_screen.dart';
import 'package:aflam/screens/turn_screen.dart';
import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock/wakelock.dart';

class GameWidget extends ConsumerStatefulWidget {
  const GameWidget({Key key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends ConsumerState<GameWidget> {
  @override
  Widget build(BuildContext context) {
    final Game game = ref.watch(gameProvider);
    bool turnEnded = ref.watch(turnEndedProvider.state).state;
    final bool _dim = ref.watch(dimmerProvider);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                '${game.teams[game.currentTeam].name}\'s Trun',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !turnEnded
                  ? CircularCountDownTimer(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.SS,
                      duration: game.settings.timer,
                      isReverse: true,
                      isTimerTextShown: true,
                      autoStart: true,
                      ringColor: Color(0xfff07c45),
                      fillColor: Color(0xff8a8a8a),
                      strokeWidth: 8.0,
                      height: double.maxFinite,
                      width: 80,
                      onComplete: () {
                        FlutterBeep.beep(false);
                        ref.read(turnEndedProvider.state).state = true;
                        ref.read(skipsProvider.state).state = -1;
                      })
                  : Text(
                      'Times Up',
                      style: TextStyle(color: colorsMap['Red'], fontSize: 32),
                    ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    clipBehavior: Clip.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                        top: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: double.maxFinite,
                                  color: GameCategories.values
                                      .firstWhere((element) =>
                                          element.title ==
                                          game.gameWords.first['Category'])
                                      .color,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        game.gameWords.isNotEmpty
                                            ? 'Category'
                                            : '',
                                      ),
                                      Text(
                                        game.gameWords.isNotEmpty
                                            ? game.gameWords.first['Category']
                                            : '',
                                        style: TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () {
                              ref.read(dimmerProvider.notifier).state = false;
                              ref
                                  .read(dimmerTimerProvider.notifier)
                                  .state
                                  .reset();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              alignment: Alignment.center,
                              foregroundDecoration: BoxDecoration(
                                  color: _dim ? Colors.black87 : null),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AutoSizeText(
                                    game.gameWords.isNotEmpty
                                        ? '${game.gameWords.first['Title En'] != '' ? game.gameWords.first['Title En'] : game.gameWords.first['Title Franco']}'
                                        : 'No more words',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                    ),
                                  ),
                                  AutoSizeText(
                                    game.gameWords.isNotEmpty
                                        ? '${game.gameWords.first['Title Ar']}'
                                        : 'No more words',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(),
        ),
      ],
    );
  }
}
