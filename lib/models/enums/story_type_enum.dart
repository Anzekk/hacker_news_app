enum StoryTypeEnum { job, story, comment, poll, pollOpt, undefined }

extension StoryTypeExtension on StoryTypeEnum {
  static StoryTypeEnum fromString(String enumString) {
    switch (enumString) {
      case 'job':
        return StoryTypeEnum.job;
      case 'story':
        return StoryTypeEnum.story;
      case 'comment':
        return StoryTypeEnum.comment;
      case 'poll':
        return StoryTypeEnum.poll;
      case 'pollopt':
        return StoryTypeEnum.pollOpt;
      default:
        return StoryTypeEnum.undefined;
    }
  }
}
