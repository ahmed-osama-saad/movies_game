import 'package:aflam/constants/strings.dart';
import 'package:aflam/models/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';

// final stateStateProvider = StateProvider.autoDispose.family<bool, String>((ref, title) {
//     return (ref.watch(pregameProvider).categories.contains(title));
//   });

class CategoryTile extends ConsumerWidget {
  CategoryTile(this.index, this.category);
  final num index;
  final GameCategories category;

  Widget build(BuildContext context, WidgetRef ref) {
    // final state = watch(stateStateProvider(title)).state;
    final preGame = ref.watch(pregameProvider);
    final state = preGame.categories.contains(category);
    return GestureDetector(
      onTap: () {
        if (!state) {
          ref.read(pregameProvider.notifier).addCategory(category);
        } else {
          ref.read(pregameProvider.notifier).removeCategory(category);
        }
      },
      child: GridTile(
        footer: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            color: category.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(state ? 'On' : 'off'),
              FlutterSwitch(
                height: 14,
                width: 50,
                toggleSize: 10,
                padding: 2,
                activeColor: Colors.black45,
                inactiveColor: Colors.black45,
                toggleColor: category.color,
                onToggle: (value) {
                  if (!state) {
                    ref.read(pregameProvider.notifier)
                        .addCategory(category);
                  } else {
                    ref.read(pregameProvider.notifier)
                        .removeCategory(category);
                  }
                },
                value: state,
              ),
            ],
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffe6e6cb),
          ),
          child: Text(
            category.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
