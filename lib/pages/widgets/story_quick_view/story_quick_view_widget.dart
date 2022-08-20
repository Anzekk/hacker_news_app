import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/pages/widgets/story_quick_view/cards/story_list_view_item_widget.dart';
import 'package:hacker_news_app/pages/widgets/story_quick_view/story_quick_view_widget_controller.dart';

class StoryQuickViewWidget extends StatefulWidget {
  final StoryRecord story;
  final List<int> initFavoriteIdList;

  const StoryQuickViewWidget({Key? key, required this.story, required this.initFavoriteIdList}) : super(key: key);

  @override
  State<StoryQuickViewWidget> createState() => _StoryQuickViewWidgetState();
}

class _StoryQuickViewWidgetState extends State<StoryQuickViewWidget> {
  late StoryQuickViewWidgetController controller;

  @override
  void initState() {
    super.initState();
    controller = StoryQuickViewWidgetController(widget.story, widget.initFavoriteIdList);
    controller.addListener(refreshPage);
  }

  @override
  void dispose() {
    controller.removeListener(refreshPage);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoryListViewItemCard(
      data: widget.story,
      isFavorite: (controller.favoriteStoryIdList.firstWhere((element) => element == widget.story.id, orElse: () => -1)) > 0 ? true : false,
      onCompleteAction: () {
        controller.refreshFavoriteStoryIdList();
      },
    );
  }

  void refreshPage() {
    if (mounted) setState(() {});
  }
}
