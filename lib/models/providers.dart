import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game.dart';

final pregameProvider =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>(
        (ref) => GameSettingsNotifier());

final gameProvider = StateNotifierProvider<GameNotifier, Game>((ref) {
  var s = ref.watch(pregameProvider);
  return GameNotifier(Game(
    remainingTurns: s.turns,
    currentTeam: 0,
    nextTeam: 1,
    gameEnded: false,
    settings: s,
    gameWords: [],
    teams: [],
  ));
});
final currentIndexStateProvider = StateProvider<int>((ref) {
  return 0;
});

final gameEndedProvider = StateProvider.autoDispose<bool>((ref) {
  return ref.watch(gameProvider).gameEnded;
});
