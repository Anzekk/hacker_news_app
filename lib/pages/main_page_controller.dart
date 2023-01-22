import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/enums/story_sort_enum.dart';
import 'package:hacker_news_app/models/enums/story_type_enum.dart';
import 'package:hacker_news_app/models/list_reply.dart';
import 'package:hacker_news_app/models/object_reply.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/repository/story_repository.dart';
import 'package:hacker_news_app/web/hacker_news_web_api.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPageController extends ChangeNotifier {
  Future<ListReply<int>>? allStoryIdListFuture;
  Future<List<StoryRecord>>? nextDataFuture;

  List<int> favoriteStoryIdList = [];
  List<int> storyIdList = [];
  List<StoryRecord> storyList = [];

  StorySortEnum sortByValue = StorySortEnum.newStories;

  ScrollController scrollController = ScrollController();

  MainPageController() {
    if (Platform.isAndroid || Platform.isIOS) {
      Hive.initFlutter('hacker_news_boxes').then((value) {
        setStoryFuture(sortByValue);
      });
    } else {
      Hive.init('hacker_news_boxes');
      setStoryFuture(sortByValue);
    }
  }

  void setStoryFuture(StorySortEnum value) {
    storyIdList.clear();
    storyList.clear();
    allStoryIdListFuture = HackerNewsWebApi.getStoryIdList(value).then((value) {
      if (value.data?.isNotEmpty ?? false) {
        storyIdList = value.data!;
      } else {
        storyIdList = [];
      }
      fetchFavoritesList();
      fetchNextData();
      return value;
    });
    notifyListeners();
  }

  setSortByValue(StorySortEnum? value) {
    if (value != null) {
      sortByValue = value;
      setStoryFuture(sortByValue);
    }
  }

  Future<void> fetchNextData() async {
    nextDataFuture = Future.value([for (int index = storyList.length; index < min(storyList.length + 20, storyIdList.length); index++) StoryRepository.load(storyIdList[index])]).then((value) async {
      List<Future<ObjectReply<StoryRecord>>> listOfResults = value;
      for (Future<ObjectReply<StoryRecord>> futureStoryObjectReply in listOfResults) {
        var storyObjectReply = await futureStoryObjectReply;
        if (storyObjectReply.data?.getStoryTypeEnum == StoryTypeEnum.story) {
          storyList.add(storyObjectReply.data!);
        }
      }
      return storyList;
    });
    notifyListeners();
  }

  Future<void> fetchFavoritesList() async {
    favoriteStoryIdList = await StoryRepository.getAllFavorites().then((value) {
      return value.data ?? [];
    });
    notifyListeners();
  }
}
