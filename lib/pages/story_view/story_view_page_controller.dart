import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/repository/story_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart' as webview_windows;

class StoryViewPageController extends ChangeNotifier {
  final Completer<WebViewController> mobileWebViewController = Completer<WebViewController>();
  final desktopWebViewController = webview_windows.WebviewController();

  final StoryRecord data;

  Future<bool>? favoriteFuture;

  @override
  void dispose() {
    desktopWebViewController.suspend();
    super.dispose();
  }

  StoryViewPageController(this.data) {
    setFavoriteFuture();
    desktopWebViewController.initialize().then((value) {
      if (data.url != null) {
        desktopWebViewController.loadUrl(data.url!);
      }
      notifyListeners();
    });
  }

  void addStoryToFavorites() {
    StoryRepository.addFavoriteStory(data.id!);
    notifyListeners();
    setFavoriteFuture();
  }

  void removeStoryFromFavorites() {
    StoryRepository.removeFavoriteStory(data.id!);
    notifyListeners();
    setFavoriteFuture();
  }

  void setFavoriteFuture() {
    favoriteFuture = StoryRepository.isFavorite(data.id!);
  }
}
