import 'package:aflam/constants/strings.dart';
import 'package:aflam/models/providers.dart';
import 'package:aflam/models/game.dart';
import 'package:aflam/screens/load_game_page.dart';
import 'package:aflam/widgets/form_button.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: _AddTeamsConsumer(),
      sheet: _SheetConsumer(),
    );
  }
}

class _AddTeamsConsumer extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Game game = ref.watch(gameProvider);
    void _onChanged(int i, String s) {
      if (_formKey.currentState.saveAndValidate()) {
        // String name = _formKey.currentState.value['Team name $i'];
        ref.read(gameProvider.notifier).editTeam(i, s);
      }
    }

    List<FormBuilderTextField> teamTextFieldsList() {
      List<FormBuilderTextField> fieldsList = <FormBuilderTextField>[]..length =
          game.teams.length;
      for (int i = 0; i < game.teams.length; i++) {
        fieldsList[i] = FormBuilderTextField(
          name: 'Team name $i',
          // key: ObjectKey(i.toString()),
          initialValue: '${game.teams[i].name}',
          // controller: TextEditingController(text: game.teams[i].name),
          onChanged: (_) => _onChanged(i, _),
          // valueTransformer: (text) => num.tryParse(text),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.max(context, 70),
          ]),
          keyboardType: TextInputType.name,
          // textCapitalization: TextCapitalization.none,
        );
      }
      // print(fieldsList);
      return fieldsList;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: AutoSizeText(
              'Team names',
              style: TextStyle(
                color: Color(0xfff9f9e2),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            color: Color(0xfff9f9e2),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...teamTextFieldsList(),
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
    );
  }
}

class _SheetConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameSettings game = ref.watch(pregameProvider);
    return FormButton(
        title: game.mode.toString().split('.').last.toUpperCase(),
        // buttonColor: game.colorMap[GameMode.values.indexOf(game.mode)],
        buttonColor: game.mode.color,
        subtitle: '',
        callback: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoadGamePage(),
              ));
        });
  }
}
