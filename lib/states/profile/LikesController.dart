import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/states/profile/ListController.dart';

class LikesController extends ListController<Photo> {
  final String userName;

  LikesController(this.userName);

  @override
  Future<List<Photo>> load({int page, int pageSize}) {
    return DataProvider.getLikesByUser(userName: userName, page: page, pageSize: pageSize);
  }
}
