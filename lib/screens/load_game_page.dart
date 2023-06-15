import 'package:aflam/models/database_helper.dart';
import 'package:aflam/screens/start_game_screen.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class LoadGamePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(wordsProvider.notifier).getWords();
    final data = ref.watch(wordsProvider);
    return StartGameScreen(data);
  }
}
