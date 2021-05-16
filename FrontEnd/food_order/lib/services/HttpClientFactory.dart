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
