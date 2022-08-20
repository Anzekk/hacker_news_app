import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/enums/story_sort_enum.dart';
import 'package:hacker_news_app/util/text_style_helper.dart';

class ActionHeaderToolbarWidget extends StatelessWidget {
  final Function(StorySortEnum? value) onChangeValue;
  final StorySortEnum selectedValue;

  const ActionHeaderToolbarWidget({Key? key, required this.onChangeValue, required this.selectedValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text('Sort by: ', style: TextStyleHelper.body()),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<StorySortEnum>(
                borderRadius: BorderRadius.circular(15),
                focusColor: Colors.transparent,
                value: selectedValue,
                items: [
                  DropdownMenuItem(
                    value: StorySortEnum.newStories,
                    child: Text('New stories', style: TextStyleHelper.small()),
                  ),
                  DropdownMenuItem(
                    value: StorySortEnum.topStories,
                    child: Text('Top stories', style: TextStyleHelper.small()),
                  ),
                  DropdownMenuItem(
                    value: StorySortEnum.bestStories,
                    child: Text('Best stories', style: TextStyleHelper.small()),
                  ),
                ],
                onChanged: onChangeValue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
