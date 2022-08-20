import 'package:hacker_news_app/models/list_reply.dart';
import 'package:hacker_news_app/models/object_reply.dart';
import 'package:hacker_news_app/models/story_record.dart';
import 'package:hacker_news_app/web/hacker_news_web_api.dart';
import 'package:hive/hive.dart';

class StoryRepository {
  static const String _hiveString = 'story';
  static const String _favoritesHiveString = 'favorite_story';
  static Box<StoryRecord>? box;
  static Box<int>? favoritesBox;

  static Future<Box<StoryRecord>> initialize() async {
    if (Hive.isAdapterRegistered(StoryRecordAdapter().typeId) == false) Hive.registerAdapter(StoryRecordAdapter());

    box = await Hive.openBox(_hiveString);
    return box!;
  }

  static Future<Box<int>> favoriteInitialize() async {
    favoritesBox = await Hive.openBox(_favoritesHiveString);

    return favoritesBox!;
  }

  static Future<ObjectReply<StoryRecord>> load(int id) async {
    box ??= await initialize();

    StoryRecord? repoStory = box?.get(id);
    if (repoStory != null) {
      return ObjectReply<StoryRecord>(data: repoStory);
    }

    ObjectReply<StoryRecord> response = await HackerNewsWebApi.getStory(id);

    if (response.data != null) {
      box!.put(id, response.data!);
    }

    return response;
  }

  static Future<void> addFavoriteStory(int id) async {
    favoritesBox ??= await favoriteInitialize();

    favoritesBox!.put(id, id);
  }

  static Future<void> removeFavoriteStory(int id) async {
    favoritesBox ??= await favoriteInitialize();

    favoritesBox!.delete(id);
  }

  static Future<bool> isFavorite(int id) async {
    favoritesBox ??= await favoriteInitialize();

    return favoritesBox!.containsKey(id);
  }

  static Future<ListReply<int>> getAllFavorites() async {
    favoritesBox ??= await favoriteInitialize();

    return ListReply(data: favoritesBox!.values.toList());
  }
}
