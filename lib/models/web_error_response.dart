class WebErrorRecord {
  final int errorCode;
  final String error;

  WebErrorRecord({required this.errorCode, required this.error});

  WebErrorRecord.empty({this.errorCode = 0, this.error = ''});

  bool get hasError => error.isNotEmpty || errorCode < 0;
}
