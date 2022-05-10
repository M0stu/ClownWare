import 'dart:io';
import 'dart:async';

//Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

const String USER_COLLECTION = "Users";

class CloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CloudStorageService() {}

  Future<String?> saveUserImageToStorage(String _uid) async {
    try {
      Reference _ref = _storage.ref().child('images/users/$_uid/');

      File f = await getImageFileFromAssets('Assets/img/profile.jpg');
      UploadTask _task = _ref.putFile(f);
      return await _task.then(
        (_result) => _result.ref.getDownloadURL(),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> saveChatImageToStorage(
      String _chatID, String _userID, PlatformFile _file) async {
    try {
      Reference _ref = _storage.ref().child(
          'images/chats/$_chatID/${_userID}_${Timestamp.now().millisecondsSinceEpoch}.${_file.extension}');
      UploadTask _task = _ref.putFile(
        File(_file.path!),
      );
      return await _task.then(
        (_result) => _result.ref.getDownloadURL(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
