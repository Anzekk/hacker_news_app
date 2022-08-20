enum StorySortEnum { topStories, newStories, bestStories }

extension StorySortExtension on StorySortEnum {
  String toStringForWeb() {
    switch (this) {
      case StorySortEnum.topStories:
        return 'topstories';
      case StorySortEnum.bestStories:
        return 'beststories';
      case StorySortEnum.newStories:
      default:
        return 'newstories';
    }
  }
}
