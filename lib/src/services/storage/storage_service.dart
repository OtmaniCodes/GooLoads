import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/utils/logger.dart';
import 'package:gooloads/src/utils/service_locator.dart';


class StorageService {
  FirebaseStorage _storage = FirebaseStorage.instance;

  String _getUserID() =>
      serviceLocator<AuthService>().getUserCredentials()?.uid ?? "";

  Future<void> uploadProfilePhoto(File file) async {
    String userId = _getUserID.call();
    Reference profilePhotosRef =
        _storage.ref().child("profile_photos").child("$userId.jpg");
    TaskSnapshot _uploadTask =
        await profilePhotosRef.putFile(file).catchError((error) {
      print(error);
    });
    if (_uploadTask.state == TaskState.success) {
      DevLogger.log("profile photo is successfully uploaded",
          name: "uploadProfilePhoto");
    } else {
      DevLogger.log("profile photo is not successfully uploaded",
          name: "uploadProfilePhoto");
    }
  }

  getProfilePhotoUrl() async {
    String userId = _getUserID.call();
    Reference profilePhotosRef =
        _storage.ref().child("profile_photos").child("$userId.jpg");
    try {
      String _profilePhotoUrl = await profilePhotosRef.getDownloadURL();
      return _profilePhotoUrl;
    } catch (e) {
      print(e);
      return '';
    }
  }
}
