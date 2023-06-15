import 'package:aflam/constants/strings.dart';
import 'package:flutter/material.dart';

import 'category_tile.dart';

class CategoriesList extends StatelessWidget {
  final List<GameCategories> catList;

  CategoriesList(this.catList);
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      delegate: SliverChildBuilderDelegate(
        (context, index) => CategoryTile(index, catList[index]),
        childCount: catList.length,
      ),
    );
  }
}
