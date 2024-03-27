part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class UpdateProfilePhotoEvent extends ImagePickerEvent{
  final bool initial;
  final bool fromCamera;
  UpdateProfilePhotoEvent({required this.fromCamera, this.initial = false});

}
