import 'package:flutter/material.dart';
import 'package:hacker_news_app/util/text_style_helper.dart';

class PointsWidget extends StatelessWidget {
  final int points;

  const PointsWidget({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${points.toString()} ${points > 1 || points == 0 ? 'points' : 'point'} ',
      style: TextStyleHelper.small(),
    );
  }
}
