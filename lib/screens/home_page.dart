import 'package:aflam/constants/strings.dart';
import 'package:aflam/models/providers.dart';
import 'package:aflam/screens/game_form.dart';
import 'package:aflam/widgets/categories_list.dart';
import 'package:aflam/widgets/form_button.dart';
import 'package:aflam/widgets/mode_selector.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key key, this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(pregameProvider);

    return MyScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Game Mode',
                    style: TextStyle(
                      color: Color(0xfff9f9e2),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ModeSelector(),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Choose Decks',
                    style: TextStyle(
                      color: Color(0xfff9f9e2),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  sliver: CategoriesList(GameCategories.values.toList())),
              SliverPadding(padding: EdgeInsets.only(bottom: 139)),
            ],
          ),
        ),
      ),
      sheet: FormButton(
        title: game.mode.toString().split('.').last.toUpperCase(),
        buttonColor: game.mode.color,
        subtitle: game.mode.homeScreenButton,
        callback: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => GameForm())),
      ),
    );
  }
}
