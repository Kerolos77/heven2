

import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())?.path;
  final newPath = '/storage/emulated/0/Heven2';
  if (await Permission.contacts.request().isGranted) {
    new Directory(newPath).create()
    // The created directory is returned as a Future.
        .then((Directory directory) {
      print('--------${directory.path}');
    });
  }


  // print ("+++++++++++${path}");// /storage/emulated/0/
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}