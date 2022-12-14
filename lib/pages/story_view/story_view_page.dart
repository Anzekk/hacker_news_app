import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hacker_news_app/core/indicators/error_indicator.dart';
import 'package:hacker_news_app/core/indicators/loading_indicator.dart';
import 'package:hacker_news_app/pages/story_view/story_view_page_controller.dart';
import 'package:hacker_news_app/pages/widgets/story_quick_view/cards/widgets/favorite_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart' as webview_windows;

class StoryViewPage extends StatefulWidget {
  final StoryViewPageController controller;

  const StoryViewPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.controller.data.title}'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<bool>(
                initialData: widget.controller.data.isFavorite,
                future: widget.controller.favoriteFuture,
                builder: (context, snapshot) {
                  bool isFavorite = snapshot.data ?? false;
                  return IconButton(
                    tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                    onPressed: () {
                      if (isFavorite) {
                        widget.controller.removeStoryFromFavorites();
                      } else {
                        widget.controller.addStoryToFavorites();
                      }
                    },
                    icon: FavoriteWidget(emptyStar: !isFavorite, isBig: true),
                  );
                },
              ),
            ),
          ],
        ),
        body: getWebView(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(refreshPage);
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  @override
  void dispose() {
    widget.controller.removeListener(refreshPage);
    super.dispose();
  }

  Widget getWebView() {
    if (Platform.isAndroid || Platform.isIOS) {
      return WebView(
        initialUrl: widget.controller.data.url,
        onWebViewCreated: (WebViewController controller) {
          widget.controller.mobileWebViewController.complete(controller);
        },
      );
    }
    if (widget.controller.data.url?.isEmpty ?? true) {
      return const ErrorIndicator(errorMessage: 'No url available for story.');
    }

    if (Platform.isWindows) {
      if (!widget.controller.desktopWebViewController.value.isInitialized) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: const [
              LoadingIndicator(),
              Text(
                'Initializing web view',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      }

      return webview_windows.Webview(
        widget.controller.desktopWebViewController,
      );
    }

    return const ErrorIndicator(errorMessage: 'Unknown error');
  }

  void refreshPage() {
    if (mounted) {
      setState(() {});
    }
  }
}
