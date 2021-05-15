import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

bool initialized=false;

class TestClass{
     static void callback(String id, DownloadTaskStatus status, int progress) {}
}

void Download(String link) async {

  if(!initialized){
    FlutterDownloader.registerCallback(TestClass.callback);
    initialized=true;}

  final status = await Permission.storage.request();
  final externalDir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
  print(externalDir);

  if (status.isGranted) {
    final externalDir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    print(externalDir);

    final id = await FlutterDownloader.enqueue(
      url:link,
      savedDir: externalDir,
      fileName: '${link.hashCode.toString()}.jpg',
      showNotification: true,
      openFileFromNotification: true,
    );
  } else {
    print("Permission deined");
  }
}
