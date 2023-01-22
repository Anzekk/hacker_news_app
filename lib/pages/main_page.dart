import 'package:flutter/material.dart';
import 'package:hacker_news_app/core/indicators/loading_indicator.dart';
import 'package:hacker_news_app/models/list_reply.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/pages/main_page_controller.dart';
import 'package:hacker_news_app/pages/widgets/action_header_toolbar_widget.dart';
import 'package:hacker_news_app/pages/widgets/story_quick_view/story_quick_view_widget.dart';
import 'package:hacker_news_app/util/text_style_helper.dart';

class MainPage extends StatefulWidget {
  final MainPageController controller;

  const MainPage(this.controller, {Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    widget.controller.addListener(refreshPage);
    widget.controller.scrollController.addListener(() {
      if (widget.controller.scrollController.position.pixels == widget.controller.scrollController.position.maxScrollExtent) {
        widget.controller.fetchNextData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(refreshPage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hacker news'),
          actions: [
            ActionHeaderToolbarWidget(
              selectedValue: widget.controller.sortByValue,
              onChangeValue: widget.controller.setSortByValue,
            ),
            IconButton(
              onPressed: () {
                widget.controller.setStoryFuture(widget.controller.sortByValue);
              },
              icon: const Icon(
                Icons.refresh,
                size: 25,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<ListReply>(
                future: widget.controller.allStoryIdListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.data?.hasError ?? false) {
                    return Text(snapshot.data!.getErrorLabel);
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.all(4.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        widget.controller.setStoryFuture(widget.controller.sortByValue);
                      },
                      child: FutureBuilder<List<StoryRecord>>(
                        future: widget.controller.nextDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData && (snapshot.data?.isNotEmpty ?? false)) {
                            return const LoadingIndicator();
                          }
                          return Stack(
                            children: [
                              ListView.builder(
                                cacheExtent: 3,
                                controller: widget.controller.scrollController,
                                itemCount: widget.controller.storyList.length,
                                itemBuilder: (context, index) {
                                  var storyData = widget.controller.storyList.elementAt(index);
                                  return StoryQuickViewWidget(
                                    story: storyData,
                                    initFavoriteIdList: widget.controller.favoriteStoryIdList,
                                  );
                                },
                              ),
                              if (snapshot.connectionState == ConnectionState.waiting)
                                const Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: LoadingIndicator(),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void refreshPage() {
    if (mounted) setState(() {});
  }
}
