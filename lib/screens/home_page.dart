import 'package:aflam/constants/strings.dart';
import 'package:aflam/widgets/form_button.dart';
import 'package:aflam/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/providers.dart';
import '../widgets/categories_list.dart';
import '../widgets/mode_selector.dart';
import 'game_form.dart';

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
        // buttonColor: game.colorMap[GameMode.values.indexOf(game.mode)],
        buttonColor: game.mode.color,
        subtitle: game.mode.homeScreenButton,
        callback: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => GameForm())),
      ),
    );
  }
}
// Container(
//         height: 130,
//         color: Color(0xfff9f9e2),
//         padding: EdgeInsets.all(15),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             primary: game.colorMap[GameMode.values.indexOf(game.mode)],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//             ),
//             elevation: 5,
//           ),
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => GameForm()));
//           },
//           child: Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         game.mode.toString().split('.').last,
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w700),
//                       ),
//                       Text(
//                         'Lorem ipsum a simple dummy text from the late century',
//                         maxLines: 2,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     child: SvgPicture.asset(
//                       'assets/playIcon.svg',
//                       height: 50,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),