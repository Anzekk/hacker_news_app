import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/enums/story_sort_enum.dart';
import 'package:hacker_news_app/util/text_style_helper.dart';

class ActionHeaderToolbarWidget extends StatelessWidget {
  final Function(StorySortEnum? value) onChangeValue;
  final StorySortEnum selectedValue;

  const ActionHeaderToolbarWidget({Key? key, required this.onChangeValue, required this.selectedValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<StorySortEnum>(
        borderRadius: BorderRadius.circular(15),
        focusColor: Colors.transparent,
        iconEnabledColor: Colors.white,
        value: selectedValue,
        selectedItemBuilder: (context) => getItemList(textStyle: const TextStyle(color: Colors.white)),
        items: getItemList(),
        onChanged: onChangeValue,
      ),
    );
  }

  List<DropdownMenuItem<StorySortEnum>> getItemList({TextStyle? textStyle}) {
    return [
      DropdownMenuItem(
        value: StorySortEnum.newStories,
        child: Text('New stories', style: textStyle),
      ),
      DropdownMenuItem(
        value: StorySortEnum.topStories,
        child: Text('Top stories', style: textStyle),
      ),
      DropdownMenuItem(
        value: StorySortEnum.bestStories,
        child: Text('Best stories', style: textStyle),
      ),
    ];
  }
}
