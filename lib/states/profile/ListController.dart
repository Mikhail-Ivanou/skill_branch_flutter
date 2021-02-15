import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:get/get.dart';

abstract class ListController<T> extends GetxController {
  int page = 0;
  final RxList<T> result = <T>[].obs;
  final inProgress = true.obs;

  ListController();

  void fetch() async {
    inProgress.value = true;
    try {
      var val = await load(page: page, pageSize: 15);
      result.assignAll(val);
    } finally {
      inProgress.value = false;
    }
  }

  Future<List<T>> load({int page, int pageSize});
}
