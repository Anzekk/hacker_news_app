import 'dart:convert';

import 'package:hacker_news_app/models/web_error_response.dart';
import 'package:http/http.dart' as http;

class WebErrorCheck {
  static WebErrorRecord execute(http.Response response) {
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return WebErrorRecord(errorCode: response.statusCode, error: json.toString());
    }
    if (json == null) {
      return WebErrorRecord(errorCode: -22, error: 'Empty response');
    }

    /// Further checks else  => empty == no error

    return WebErrorRecord.empty();
  }
}
