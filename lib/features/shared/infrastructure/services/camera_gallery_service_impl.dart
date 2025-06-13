import 'package:image_picker/image_picker.dart';
import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image == null) return null;
    print('Image selected: ${image.path}');
    return image.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (image == null) return null;
    print('Image picked: ${image.path}');
    return image.path;
  }
}
