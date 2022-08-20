import 'dart:convert';

import 'package:hacker_news_app/const/web_params.dart';
import 'package:hacker_news_app/models/enums/story_sort_enum.dart';
import 'package:hacker_news_app/models/list_reply.dart';
import 'package:hacker_news_app/models/object_reply.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/models/web_error_response.dart';
import 'package:hacker_news_app/util/web_error_check.dart';
import 'package:http/http.dart' as http;

class HackerNewsWebApi {
  static http.Client client = http.Client();

  static Future<ListReply<int>> getStoryIdList(StorySortEnum value) async {
    http.Response response = await client.get(
      Uri.https(
        WebParams.hackerNews,
        '/v0/${value.toStringForWeb()}.json',
        {'print': 'pretty'},
      ),
    );

    final json = jsonDecode(response.body);
    WebErrorRecord record = WebErrorCheck.execute(response);
    if (record.hasError) {
      return ListReply()..setErrorData(record);
    }

    List<int> dataResult = json.cast<int>();

    return ListReply<int>(data: dataResult);
  }

  static Future<ObjectReply<StoryRecord>> getStory(int storyId) async {
    http.Response response = await client.get(
      Uri.https(
        WebParams.hackerNews,
        '/v0/item/$storyId.json',
        {'print': 'pretty'},
      ),
    );

    final json = jsonDecode(response.body);
    WebErrorRecord record = WebErrorCheck.execute(response);
    if (record.hasError) {
      return ObjectReply()..fromWebErrorRecord(record);
    }

    return ObjectReply<StoryRecord>(data: StoryRecord.fromJsonItem(json));
  }
}
