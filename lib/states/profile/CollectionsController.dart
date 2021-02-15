import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/collection.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/states/profile/ListController.dart';
import 'package:get/get.dart';

class CollectionsController extends ListController<Collection> {
  final String userName;

  CollectionsController(this.userName);

  @override
  Future<List<Collection>> load({int page, int pageSize}) {
    return DataProvider.getCollectionsByUser(userName: userName, page: page, pageSize: pageSize);
  }
}
