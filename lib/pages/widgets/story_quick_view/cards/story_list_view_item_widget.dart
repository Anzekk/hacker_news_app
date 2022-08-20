import 'package:flutter/material.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/pages/story_view/story_view_page.dart';
import 'package:hacker_news_app/pages/story_view/story_view_page_controller.dart';
import 'package:hacker_news_app/pages/widgets/story_quick_view/cards/widgets/comments_widget.dart';
import 'package:hacker_news_app/pages/widgets/story_quick_view/cards/widgets/favorite_widget.dart';
import 'package:hacker_news_app/pages/widgets/story_quick_view/cards/widgets/points_widget.dart';
import 'package:hacker_news_app/util/date_time_helper.dart';
import 'package:hacker_news_app/util/text_style_helper.dart';

class StoryListViewItemCard extends StatelessWidget {
  final StoryRecord data;
  final bool isFavorite;
  final Function() onCompleteAction;

  const StoryListViewItemCard({Key? key, required this.data, this.isFavorite = false, required this.onCompleteAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: isFavorite ? Border.all(color: Colors.amber, width: 3) : null, borderRadius: BorderRadius.circular(15)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              StoryViewPageController storyViewPageController = StoryViewPageController(data);
              Navigator.push(context, MaterialPageRoute(builder: (context) => StoryViewPage(controller: storyViewPageController))).whenComplete(() {
                onCompleteAction();
                storyViewPageController.dispose();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${data.title}',
                      style: TextStyleHelper.big(
                        color: const Color(0xff1d2939),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 10,
                        children: [
                          PointsWidget(points: data.score ?? 0),
                          if ((data.descendants ?? -1) >= 0)
                            CommentsWidget(
                              commentNumber: data.descendants!,
                            ),
                          if (isFavorite) const FavoriteWidget(),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        spacing: 10,
                        children: [
                          Text(data.by.toString(), style: TextStyleHelper.body(color: Colors.blueAccent)),
                          Text(
                            DateTimeHelper.getArticleDate(DateTimeHelper.convertIntToDate(data.time!)),
                            style: TextStyleHelper.small(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
