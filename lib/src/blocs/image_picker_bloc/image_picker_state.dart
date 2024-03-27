part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerState {}

class PickedPhotoLoading extends ImagePickerState {}
class PickedPhotoError extends ImagePickerState {}
class UpdateProfilePhotoResult extends ImagePickerState{
  final XFile? file;

  UpdateProfilePhotoResult({this.file});
}
