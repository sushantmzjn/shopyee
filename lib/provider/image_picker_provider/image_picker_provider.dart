import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider =
    StateNotifierProvider.autoDispose<ImagePickerProvider, XFile?>(
        (ref) => ImagePickerProvider(null));
final coverPictureProvider =
    StateNotifierProvider.autoDispose<ImagePickerProvider, XFile?>(
        (ref) => ImagePickerProvider(null));

class ImagePickerProvider extends StateNotifier<XFile?> {
  ImagePickerProvider(super.state);
  void pickImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    if (isCamera) {
      state = await picker.pickImage(source: ImageSource.camera);
    } else {
      state = await picker.pickImage(source: ImageSource.gallery);
    }
  }

  void resetImage() {
    state = null;
  }
}
