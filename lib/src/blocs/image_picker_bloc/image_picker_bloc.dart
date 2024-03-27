import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gooloads/src/services/authentication/auth_service.dart';
import 'package:gooloads/src/services/database/db_service.dart';
import 'package:gooloads/src/services/storage/storage_service.dart';
import 'package:gooloads/src/utils/service_locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(PickedPhotoLoading());
  final ImagePicker _pickedPhoto = ImagePicker();

  @override
  Stream<ImagePickerState> mapEventToState(ImagePickerEvent event) async* {
    yield PickedPhotoLoading();
    if (event is UpdateProfilePhotoEvent) {
      try {
        if(event.initial) yield UpdateProfilePhotoResult();
        else{
        StorageService _storageLocator = serviceLocator<StorageService>();
        AuthService _authLocator = serviceLocator<AuthService>();
        DataBaseService _dbLocator = serviceLocator<DataBaseService>();
        XFile? chosenProfilePhoto = await getProfilePhoto(event.fromCamera);
        if (chosenProfilePhoto != null) await _storageLocator .uploadProfilePhoto(File(chosenProfilePhoto.path));
        String _profilePhotoUrl = await _storageLocator.getProfilePhotoUrl();
        await _authLocator.saveUserPhotoUrl(_profilePhotoUrl);
        await _dbLocator.updateUserCredsInDB(
          _authLocator.getUserCredentials()!.uid,
          target: "imageUrl",
          replacement: _profilePhotoUrl,
        );
        yield UpdateProfilePhotoResult(file: chosenProfilePhoto);
       }
      } catch (e) {
        print(e);
        yield PickedPhotoError();
      }
    }
  }

  Future<XFile?> getProfilePhoto(bool fromCamera) async {
    XFile? retFile;
    bool accessGranted = await askForPermission(fromCamera);
    if (accessGranted) {
      retFile = await _pickedPhoto.pickImage(
          source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    }

    return retFile;
  }

  Future<bool> askForPermission(bool fromCamera) async {
    PermissionStatus? status;
    bool retVal = false;
    try {
      if (fromCamera)
        await Permission.camera.request();
      else
        await Permission.photos.request();
      status = fromCamera
          ? await Permission.camera.status
          : await Permission.photos.status;
    } catch (e) {
      print(e);
    }
    if (status != null) if (Platform.isIOS
        ? !(status.isDenied ||
            status.isRestricted ||
            status.isPermanentlyDenied)
        : true) retVal = true;
    return retVal;
  }
}
