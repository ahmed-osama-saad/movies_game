import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HorizontalCard extends StatelessWidget {
  final String assetSvg;
  final Color cardColor;
  final String title;
  final String subTitle;

  const HorizontalCard(
      {@required this.assetSvg,
      @required this.cardColor,
      @required this.title,
      @required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subTitle,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                child: SvgPicture.asset(assetSvg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
