import 'package:path_provider/path_provider.dart';

class FileServices {
  Future<String> get documentsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get cachePath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
}
