import 'package:download_file_dio/services/remote/main_api.dart';
import 'package:download_file_dio/widgets/loading.dart';
import 'package:download_file_dio/widgets/popup_status.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class DownloadFileScreen extends StatefulWidget {
  @override
  _DownloadFileScreenState createState() => _DownloadFileScreenState();
}

class _DownloadFileScreenState extends State<DownloadFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download File'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Download File'),
          onPressed: () async {
            showLoading(context);
            await MainApi()
                .downloadFile(
                    'http://belajar.landa.co.id/flutter_api/assets/file/flutter/employee/27022021100549_KelasMobileMalang.pdf',
                    'KelasMobileMalang')
                .then((value) {
              if (value != null) {
                hideLoading(context);
                PopupStatus.showFlushbar(
                    context, true, 'File berhasil di download');
                OpenFile.open(value);
              } else {
                hideLoading(context);
                PopupStatus.showFlushbar(
                    context, false, 'File gagal di download');
              }
            });
          },
        ),
      ),
    );
  }
}
