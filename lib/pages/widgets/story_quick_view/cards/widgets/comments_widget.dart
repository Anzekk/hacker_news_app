import 'package:flutter/material.dart';
import 'package:hacker_news_app/util/text_style_helper.dart';

class CommentsWidget extends StatelessWidget {
  final int commentNumber;

  const CommentsWidget({Key? key, required this.commentNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 4.0),
          child: Icon(Icons.message_outlined, size: 14),
        ),
        Text(commentNumber.toString(), style: TextStyleHelper.small()),
      ],
    );
  }
}
