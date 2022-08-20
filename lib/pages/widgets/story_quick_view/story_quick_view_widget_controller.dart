import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/repository/story_repository.dart';

class StoryQuickViewWidgetController extends ChangeNotifier {
  final StoryRecord story;
  List<int> favoriteStoryIdList;

  StoryQuickViewWidgetController(this.story, this.favoriteStoryIdList);

  refreshFavoriteStoryIdList() async {
    favoriteStoryIdList = await StoryRepository.getAllFavorites().then((value) {
      return value.data ?? [];
    });
    notifyListeners();
  }
}
