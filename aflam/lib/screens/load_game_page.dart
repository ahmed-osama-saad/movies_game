import 'package:aflam/models/database_helper.dart';
import 'package:aflam/screens/start_game_screen.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class LoadGamePage extends ConsumerWidget {
  // final _query = FutureProvider.autoDispose<List<Map>>((ref) async {
  //   // get a reference to the database
  //   Database db = await DatabaseHelper.instance.database;

  //   // get all rows
  //   return await db.query(DatabaseHelper.table);
  //   // result.forEach((row) => print('ROWROOW$row'));
  // });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final MySettings game = watch(pregameProvider);
    ref.read(wordsProvider.notifier).getWords();
    final data = ref.watch(wordsProvider);
    return StartGameScreen(data);
  }
}
