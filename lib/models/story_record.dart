import 'package:hacker_news_app/const/hive_params.dart';
import 'package:hacker_news_app/models/enums/story_type_enum.dart';
import 'package:hive/hive.dart';

part 'story_record.g.dart';

@HiveType(typeId: HiveParams.storyRecordTypeId)
class StoryRecord {
  @HiveField(0)
  String? by;
  @HiveField(1)
  int? descendants;
  @HiveField(2)
  int? id;
  @HiveField(3)
  List<int>? kids;
  @HiveField(4)
  int? score;
  @HiveField(5)
  int? time;
  @HiveField(6)
  String? title;
  @HiveField(7)
  String? type;
  @HiveField(8)
  String? url;
  @HiveField(9)
  bool isFavorite = false;

  get getStoryTypeEnum => StoryTypeExtension.fromString(type ?? '');

  StoryRecord({this.by, this.descendants, this.id, this.kids, this.score, this.time, this.title, this.type, this.url});

  StoryRecord.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    descendants = json['descendants'];
    id = json['id'];
    if (json['kids'] != null) {
      kids = json['kids'].cast<int>();
    }
    score = json['score'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['by'] = by;
    data['descendants'] = descendants;
    data['id'] = id;
    data['kids'] = kids;
    data['score'] = score;
    data['time'] = time;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    return data;
  }

  static StoryRecord fromJsonItem(Map<String, dynamic> json) {
    return StoryRecord.fromJson(json);
  }
}
