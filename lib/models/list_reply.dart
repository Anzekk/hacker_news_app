import 'package:hacker_news_app/models/web_error_response.dart';

class ListReply<T> {
  String error = '';
  int errorCode = 0;
  late DateTime callTime;

  List<T>? data;

  ListReply({this.error = '', this.errorCode = 0, this.data}) {
    callTime = DateTime.now();
  }

  factory ListReply.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic> json) creator) {
    ListReply<T>? result = ListReply<T>();

    var jsonData = json as List;
    result.data = jsonData.map((item) => creator(item)).toList();

    return result;
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

  void setErrorData(WebErrorRecord record) {
    error = record.error;
    errorCode = record.errorCode;
  }
}
