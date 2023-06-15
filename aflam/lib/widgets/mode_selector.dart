import 'package:aflam/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/providers.dart';
import 'horizontal_card.dart';

class ModeSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pg = ref.watch(pregameProvider);
    final int _currentIndex = ref.watch(currentIndexStateProvider.state).state;

    void _selectMode(int index) {
      ref.read(currentIndexStateProvider.state).state = index;
      ref.read(pregameProvider.notifier).setMode(GameMode.values[index]);
    }

    return SliverList(
      // children: gameModes,
      delegate: SliverChildListDelegate(
        [
          Container(
            decoration: BoxDecoration(
              border: _currentIndex == 0
                  ? Border.all(
                      color: Colors.white,
                      width: 3,
                    )
                  : Border.all(
                      color: Color(0xff140F0F),
                      width: 3,
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: GestureDetector(
              onTap: () => _selectMode(0),
              child: HorizontalCard(
                assetSvg: 'assets/massel.svg',
                cardColor: GameMode.massel.color,
                title: GameMode.massel.toString().split('.').last,
                subTitle: GameMode.massel.subtitle,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: _currentIndex == 1
                  ? Border.all(
                      color: Colors.white,
                      width: 3,
                    )
                  : Border.all(
                      color: Color(0xff140F0F),
                      width: 3,
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: GestureDetector(
              onTap: () => _selectMode(1),
              child: HorizontalCard(
                assetSvg: 'assets/ersem.svg',
                cardColor: GameMode.ersem.color,
                title: GameMode.ersem.toString().split('.').last,
                subTitle: GameMode.ersem.subtitle,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: _currentIndex == 2
                  ? Border.all(
                      color: Colors.white,
                      width: 3,
                    )
                  : Border.all(
                      color: Color(0xff140F0F),
                      width: 3,
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: GestureDetector(
              onTap: () => _selectMode(2),
              child: HorizontalCard(
                assetSvg: 'assets/khammen.svg',
                cardColor: GameMode.khammen.color,
                title: GameMode.khammen.toString().split('.').last,
                subTitle: GameMode.khammen.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
