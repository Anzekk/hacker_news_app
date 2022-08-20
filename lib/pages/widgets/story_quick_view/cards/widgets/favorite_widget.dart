import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget {
  final bool emptyStar;
  final bool isBig;

  const FavoriteWidget({Key? key, this.emptyStar = false, this.isBig = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Icon(emptyStar ? Icons.star_border_outlined : Icons.star, color: Colors.amber, size: isBig ? 28 : 16),
    );
  }
}
