import 'package:hacker_news_app/models/web_error_response.dart';

class ObjectReply<T> {
  final String error;
  final int errorCode;
  late DateTime callTime;

  T? data;

  ObjectReply({this.error = '', this.errorCode = -1, this.data}) {
    callTime = DateTime.now();
  }

  bool isNull() {
    return data == null;
  }

  bool get hasError {
    return (errorCode < 0) || ((error).isNotEmpty);
  }

  String get getErrorLabel {
    return (error.isEmpty ? (errorCode.toString()) : error);
  }

  ObjectReply<T> fromWebErrorRecord(WebErrorRecord record) {
    return ObjectReply<T>(error: record.error, errorCode: record.errorCode);
  }
}
