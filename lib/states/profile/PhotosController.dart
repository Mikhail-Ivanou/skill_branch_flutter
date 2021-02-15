import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/states/profile/ListController.dart';

class PhotosController extends ListController<Photo> {
  final String userName;

  PhotosController(this.userName);

  @override
  Future<List<Photo>> load({int page, int pageSize}) {
    return DataProvider.getPhotosByUser(userName: userName, page: page, pageSize: pageSize);
  }
}
