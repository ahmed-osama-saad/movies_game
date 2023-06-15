import 'package:aflam/constants/strings.dart';
import 'package:aflam/models/database_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettings extends Equatable {
  final GameMode mode;
  final List<GameCategories> categories;
  final num timer;
  final int turns;
  final int numberOfTeams;
  final int skips;

  GameSettings(
      {this.mode,
      this.categories,
      this.timer,
      this.turns,
      this.numberOfTeams,
      this.skips});

  GameSettings.clone(
    GameSettings g, {
    GameMode mode,
    List<GameCategories> categories,
    num timer,
    int turns,
    int numberOfTeams,
    int skips,
  }) : this(
          mode: mode ?? g.mode,
          categories: categories ?? g.categories,
          timer: timer ?? g.timer,
          turns: turns ?? g.turns,
          skips: skips ?? g.skips,
          numberOfTeams: numberOfTeams ?? g.numberOfTeams,
        );

  @override
  List<Object> get props => [mode, categories, timer, numberOfTeams, turns];
  bool get stringify => true;
}

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier()
      : super(GameSettings(
          mode: GameMode.massel,
          categories: GameCategories.values.toList(),
          timer: 0,
          turns: 20,
          numberOfTeams: 2,
          skips: 1,
        ));
  resetSettings() {
    state = GameSettings(
      mode: GameMode.massel,
      categories: GameCategories.values.toList(),
      timer: 0,
      turns: 20,
      numberOfTeams: 2,
      skips: 1,
    );
  }

  setMode(GameMode mode) {
    state = GameSettings.clone(state, mode: mode);
  }

  insertForm(num timer, int turns, int skips) {
    print('total turns $turns');
    print('skips $skips');
    state = GameSettings.clone(state, timer: timer, turns: turns, skips: skips);
  }

  addCategory(GameCategories cat) {
    var newCat = state.categories;
    newCat.add(cat);
    state = GameSettings.clone(state, categories: newCat);
    print('add cat ${state.categories}');
  }

  removeCategory(GameCategories cat) {
    var newCat = state.categories;
    newCat.remove(cat);
    state = GameSettings.clone(state, categories: newCat);
    print('rm cat ${state.categories}');
  }
}

class Game extends Equatable {
  final int remainingTurns;
  final int currentTeam;
  final int nextTeam;
  final bool gameEnded;
  final GameSettings settings;
  final List gameWords;
  final List<Team> teams;
  Game({
    this.remainingTurns,
    this.currentTeam,
    this.nextTeam,
    this.gameEnded,
    this.settings,
    this.gameWords,
    this.teams,
  });
  // TODO: add factory constructor.
  Game.clone(
    Game g, {
    int remainingTurns,
    int currentTeam,
    int nextTeam,
    GameSettings settings,
    List gameWords,
    bool gameEnded,
    List teams,
  }) : this(
          remainingTurns: remainingTurns ?? g.remainingTurns,
          currentTeam: currentTeam ?? g.currentTeam,
          nextTeam: nextTeam ?? g.nextTeam,
          gameEnded: gameEnded ?? g.gameEnded,
          settings: settings ?? g.settings,
          gameWords: gameWords ?? g.gameWords,
          teams: teams ?? g.teams,
        );
  @override
  List<Object> get props => [gameEnded, settings, gameWords];
  bool get stringify => true;
}

class GameNotifier extends StateNotifier<Game> {
  GameNotifier(Game state) : super(state);

  createTeamsList(int numberOfTeams) {
    var teamList = <Team>[]..length = numberOfTeams;
    for (var i = 0; i < numberOfTeams; i++) {
      teamList[i] = Team(
          '${colorsMap.keys.elementAt(i)}', 0, colorsMap.values.elementAt(i));
      // print('teeeem ${teamList[i].name}');
    }
    state = Game.clone(state, teams: teamList);
    print(state.teams);
  }

  addTeam(Team team) {
    var newTeams = state.teams;
    newTeams.add(team);
    state = Game.clone(state, teams: newTeams);
    // print('add team ${state.teams}');
  }

  removeTeam(int index) {
    var newTeams = state.teams;
    // print('remove team ${state.teams[index].name}');
    newTeams.removeAt(index);
    state = Game.clone(state, teams: newTeams);
  }

  editTeam(int index, String name) {
    var newTeams = state.teams;
    newTeams[index].name = name;
    state = Game.clone(state, teams: newTeams);
  }

  void createGame(List words) {
    int t = state.settings.turns - 1;
    print(words.length);
    List gameWords = getGameWords(words);
    // state.gameWords.addAll(gameWords);
    // print('gameword: ${state.gameWords}');
    state = Game.clone(
      state,
      remainingTurns: t,
      gameEnded: false,
      currentTeam: 0,
      nextTeam: 1,
      gameWords: gameWords,
    );
  }

  List getGameWords(List words) {
    int totalWeight = 0;
    state.settings.categories.forEach((element) {
      totalWeight += element.weight;
    });
    // print('total weight' + totalWeight.toString());
    int totalWords = state.settings.turns * 5;
    List retL = [];
    for (int i = 0; i < state.settings.categories.length; i++) {
      final int categoryWeight = state.settings.categories[i].weight;
      int wpc = ((categoryWeight / totalWeight) * totalWords).round();
      // print(
      //     'wpc $wpc category weigth $categoryWeight total weight $totalWeight $totalWords');
      retL += getCategoryWords(words, state.settings.categories[i], wpc);
    }
    retL.shuffle();
    return retL;
  }

  List getCategoryWords(
      List words, GameCategories category, int numberOfWords) {
    List cwords = [];
    List retL = [];
    words.forEach((element) {
      if (element['Category'] == category.title) cwords.add(element);
    });
    print('cwords $cwords');

    for (int i = 0; i < numberOfWords; i++) {
      if (cwords.isNotEmpty) {
        cwords.shuffle();
        retL.add(cwords[0]);
        cwords.removeAt(0);
      }
    }
    return retL;
  }

  submitAns(bool ans) {
    if (ans) {
      state.teams[state.currentTeam].score++;
    }
  }

  nextWord(WidgetRef ref) {
    if (state.gameWords.length > 10) {
      state.gameWords.removeAt(0);
      state = Game.clone(
        state,
      );
      print("next word ${state.gameWords}");
    } else {
      state.gameWords.removeAt(0);
      List words = ref.watch(wordsProvider);
      List gameWords = getGameWords(words);
      print('Loading more words');
      state = Game.clone(state, gameWords: gameWords);
    }
  }

  nextTurn() {
    int currentTeam = state.currentTeam;
    int nextTeam = state.nextTeam;
    state.currentTeam < state.teams.length - 1
        ? currentTeam++
        : currentTeam = 0;
    state.nextTeam < state.teams.length - 1 ? nextTeam++ : nextTeam = 0;
    int t = state.remainingTurns - 1;
    if (t > 0) {
      state = Game.clone(state, remainingTurns: t);
    } else {
      endGame();
      print('no More Turns');
    }
    if (state.gameWords.length > 1) {
      state.gameWords.removeAt(0);
      print("next turn ${state.gameWords}");
    } else {
      state.gameWords.removeAt(0);
      endGame();
      print('Game ended');
    }
    state = Game.clone(state, currentTeam: currentTeam, nextTeam: nextTeam);
  }

  // Add Tiebreaker
  Team findWinner() {
    var winner = state.teams[0];
    state.teams.forEach((element) {
      if (element.score > winner.score) winner = element;
    });
    return winner;
  }

  endGame() {
    state = Game.clone(state, gameEnded: true);
  }

  String currentGameWord() {
    return state.gameWords.first['name'];
  }
}

class Team {
  String name;
  Color color;
  num score;
  Team(this.name, this.score, this.color);
}
