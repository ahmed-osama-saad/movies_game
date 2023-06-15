import 'package:aflam/constants/strings.dart';
import 'package:aflam/models/game.dart';
import 'package:aflam/models/providers.dart';
import 'package:aflam/screens/add_teams_page.dart';
import 'package:aflam/widgets/form_button.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class GameForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameSettings game = ref.watch(pregameProvider);

    return MyScaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'GAME SETTINGS',
                  style: TextStyle(
                    color: Color(0xfff9f9e2),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                color: Color(0xffe6e6cb),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How To Play',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: AutoSizeText(
                            game.mode.howToText,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Color(0xffe6e6cb),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderSlider(
                          decoration: InputDecoration(
                            labelText: 'Turn timer in seconds'.toUpperCase(),
                            border: InputBorder.none,
                          ),
                          name: 'timer',
                          initialValue: 30,
                          divisions: 11,
                          numberFormat: NumberFormat('##0'),
                          min: 10,
                          max: 120,
                          valueTransformer: (value) => value.floor(),
                          activeColor: const Color.fromARGB(255, 112, 230, 191),
                        ),
                        FormBuilderSlider(
                          decoration: InputDecoration(
                            labelText: 'Number of teams'.toUpperCase(),
                            border: InputBorder.none,
                          ),
                          name: 'teams',
                          numberFormat: NumberFormat('#0'),
                          initialValue: 2,
                          divisions: 8,
                          min: 2,
                          max: 10,
                          valueTransformer: (value) => value.round(),
                          activeColor: const Color.fromARGB(255, 112, 230, 191),
                        ),
                        FormBuilderSlider(
                          decoration: InputDecoration(
                            labelText: 'Number of turns per team'.toUpperCase(),
                            border: InputBorder.none,
                          ),
                          name: 'turns',
                          numberFormat: NumberFormat('#0'),
                          initialValue: 5,
                          min: 3,
                          max: 20,
                          divisions: 17,
                          valueTransformer: (value) => value.round(),
                          activeColor: const Color.fromARGB(255, 112, 230, 191),
                        ),
                        FormBuilderSlider(
                          decoration: InputDecoration(
                            labelText: 'Number of skips per turn'.toUpperCase(),
                            border: InputBorder.none,
                          ),
                          name: 'skips',
                          numberFormat: NumberFormat('#0'),
                          initialValue: 1,
                          min: 0,
                          max: 5,
                          divisions: 5,
                          valueTransformer: (value) => value.round(),
                          activeColor: const Color.fromARGB(255, 112, 230, 191),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 139,
              )
            ],
          ),
        ),
      ),
      sheet: FormButton(
        title: game.mode.toString().split('.').last.toUpperCase(),
        buttonColor: game.mode.color,
        subtitle: game.mode.settingsScreenButton,
        callback: () {
          _formKey.currentState.save();
          if (_formKey.currentState.validate()) {
            print(_formKey.currentState.value);
            var formstate = _formKey.currentState.value;
            ref.read(pregameProvider.notifier).insertForm(
                  formstate['timer'],
                  formstate['turns'] * formstate['teams'],
                  formstate['skips'],
                );
            ref.read(gameProvider.notifier).createTeamsList(formstate['teams']);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddTeamsPage();
                },
              ),
            );
          } else {
            print("validation failed");
          }
        },
      ),
    );
  }
}
