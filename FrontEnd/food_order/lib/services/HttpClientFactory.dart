import 'dart:io';

import 'package:http/io_client.dart';

class HttpClientFactory {
  IOClient createIOClient() {
    HttpClient httpClient = new HttpClient();
    // ..badCertificateCallback =
    //     ((X509Certificate cert, String host, int port) {
    //   return true;
    // });
    return new IOClient(httpClient);
  }
}

class HTTPStatusCode {
  static const int OK = 200;
  static const int Created = 201;
  static const int NoContent = 204;
  static const int NotModified = 304;
  static const int BadRequest = 400;
  static const int Unauthorized = 401;
  static const int Forbidend = 403;
  static const int NotFound = 404;
  static const int MethodNotAllowed = 405;
}
