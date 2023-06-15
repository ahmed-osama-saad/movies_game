import 'package:flutter/material.dart';

enum GameMode {
  massel,
  ersem,
  khammen,
}

extension GameModeExtension on GameMode {
  static const colors = {
    GameMode.massel: const Color.fromARGB(255, 112, 230, 191),
    GameMode.ersem: const Color.fromARGB(255, 253, 194, 56),
    GameMode.khammen: const Color.fromARGB(255, 250, 51, 83),
  };
  Color get color => colors[this];

  static const subtitles = {
    GameMode.massel: 'Act the word for your teammates to guess.',
    GameMode.ersem:
        'Get a paper out and draw the word for your teammates to guess.',
    GameMode.khammen:
        'Put the phone on your forehead and ask the right questions till you guess the word.',
  };
  String get subtitle => subtitles[this];

  static const homeScreenButtons = {
    GameMode.massel: 'Choose teams, game settings.',
    GameMode.ersem: 'Choose teams, game settings.',
    GameMode.khammen: 'Choose teams, game settings.',
  };
  String get homeScreenButton => homeScreenButtons[this];

  static const settingsScreenButtons = {
    GameMode.massel: 'All set, Let’s go.',
    GameMode.ersem: 'Get your paper and pen, Let’s go.',
    GameMode.khammen: 'All set, Let’s go.',
  };
  String get settingsScreenButton => settingsScreenButtons[this];

  static const startScreenButtonTexts = {
    GameMode.massel: 'Timer will start when you click.',
    GameMode.ersem: 'Timer will start when you click.',
    GameMode.khammen: 'Timer will start when you click.',
  };
  String get startScreenButton => startScreenButtonTexts[this];

  static const howToTexts = {
    GameMode.massel: '''1. Divide yourselves into teams 
2. Choose a Team Pilot for each team.
3. Team Pilot will act the first word.
4. When it’s your turn to act, say the displayed Category out loud (e.g Film & TV, Famous Person, Science, etc) and start drawing.
* Remember not to say the word itself accidentally!
5. If your team members guess it within time, you get the point. If not then too bad! NEXT...''',
    GameMode.ersem: '''1. Divide yourselves into teams 
2. Choose a Team Pilot for each team.
3. Team Pilot will draw the first word.
4. When it’s your turn to draw, say the displayed Category out loud (e.g Film & TV, Famous Person, Science, etc) and start drawing.
*Remember not to say the word itself accidentally!
5. If your team members guess it within time, you get the point. If not then too bad! NEXT...''',
    GameMode.khammen: '''1. Divide yourselves into teams 
2. Choose a Team Pilot for each team.
3. Team Pilot will guess the first word.
4. When it’s your turn to guess, hold the phone facing towards your team members so they can see but you can’t
*Take care not to see the word yourself
5. They will say the displayed Category out loud (e.g Film & TV, Famous Person, Science, etc) and you can start asking the right questions.
*Remember only “Yes/No” questions allowed
6. If your guess it within time, you get the point. If not then too bad! NEXT...''',
  };
  String get howToText => howToTexts[this];

  String startScreenText(String teamName) {
    switch (this) {
      case GameMode.massel:
        return '''Give the phone to team $teamName actor. ''';
      case GameMode.ersem:
        return '''Give the phone to who will draw for team $teamName.
Make sure you have pens and paper and your teammates can see your drawing.''';
      case GameMode.khammen:
        return '''Give the phone to who will guess from team $teamName.
Make sure your don’t look at the word but your teammates can see it.''';
      default:
        return '';
    }
  }
}

const colorsMap = {
  "Purple": Color(0xffbd7d99),
  "Cyan": Color(0xff70e6bf),
  "Yellow": Color(0xfffdc238),
  "Blue": Color(0xff368bff),
  "Pink": Color(0xffff65a2),
  "Red": Color(0xfffa3353),
  "Orange": Color(0xffff7736),
  "Green": Color(0xff99fa5c),
  "Sand": Color(0xffffde65),
  "Coral": Color(0xffff5d5d),
  "Grey": Color(0xffb2b2b2),
};

// const categoriesList = {
//   'Films': Color(0xfffdc238),
//   'Famous Person': Color(0xffbd7d99),
//   'Science': Color(0xff70e6bf),
//   'Countries': Color(0xff368bff),
//   'Internet & Memes': Color(0xffff65a2),
// };

enum GameCategories {
  countries,
  famousPerson,
  films,
  internetAndMemes,
  science,
}

extension GameCategoriesExtension on GameCategories {
  static const categoryTitles = {
    GameCategories.countries: 'Countries',
    GameCategories.famousPerson: 'Famous Person',
    GameCategories.films: 'Films',
    GameCategories.internetAndMemes: 'Internet & Memes',
    GameCategories.science: 'Science',
  };
  String get title => categoryTitles[this];

  static const categoryColors = {
    GameCategories.countries: const Color(0xff368bff),
    GameCategories.famousPerson: const Color(0xffbd7d99),
    GameCategories.films: const Color(0xfffdc238),
    GameCategories.internetAndMemes: const Color(0xffff65a2),
    GameCategories.science: const Color(0xff70e6bf),
  };
  Color get color => categoryColors[this];

  static const categoryWeights = {
    GameCategories.countries: 1,
    GameCategories.famousPerson: 1,
    GameCategories.films: 1,
    GameCategories.internetAndMemes: 1,
    GameCategories.science: 1,
  };

  int get weight => categoryWeights[this];
}
