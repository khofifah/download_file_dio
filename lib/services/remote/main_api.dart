import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:download_file_dio/services/remote/api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class MainApi extends Api {
  Future<String> downloadFile(String url, String title) async {
    String filePath;
    Directory extDir;

    var status = await Permission.storage.status;

    try {
      if (!status.isGranted) {
        await Permission.storage.request();
      } else {
        if (Platform.isIOS) {
          extDir = await getApplicationDocumentsDirectory();
          filePath = path.join(extDir.path, '$title.pdf');
        } else {
          extDir = await getExternalStorageDirectory();
          final dirPath = extDir.path.toString().substring(0, 20);
          await Directory(dirPath).create(recursive: true);
          filePath = '${dirPath}Download/$title.pdf';
        }
      }

      await dio.download(url, filePath);
      return filePath;
    } catch (e) {
      return null;
    }
  }
}
