import 'package:aflam/models/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreBoard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var game = ref.watch(gameProvider);

    return GridView.builder(
      itemCount: game.teams.length,
      physics: PageScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return GridTile(
          child: Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
                top: Radius.circular(4),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    color: game.teams[index].color,
                    child: Text(
                      game.teams[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.center,
                    color: Color(0xffe6e6cb),
                    child: Text(
                      game.teams[index].score.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 64,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
