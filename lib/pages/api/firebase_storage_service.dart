import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:queimadas/pages/api/firebase_service.dart';


class FirebaseStorageService {

  Future<String> uploadFile(File file, {String id}) async {

    final StorageReference refUser = FirebaseStorage().ref().child("users").child(fireBaseUserUid);
    final StorageReference ref = refUser.child(id ?? file.path);

    StorageUploadTask task = ref.putFile(file);
    final stream = task.events.listen((event) {
      print("UPLOAD FILE $id : ${event.type}");
    });

    StorageTaskSnapshot storageTask = await task.onComplete;
    stream.cancel();

    return storageTask.ref.getDownloadURL();

  }


}