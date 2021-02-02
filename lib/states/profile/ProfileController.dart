import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/user.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final profile = User().obs;
  final inProgress = true.obs;

  void fetchProfile() async {
    inProgress.value = true;
    try {
      var val = await DataProvider.getProfile();
      profile.value = val;
    } finally {
      inProgress.value = false;
    }
  }
}
