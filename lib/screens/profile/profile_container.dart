import 'package:FlutterGalleryApp/models/user.dart';
import 'package:FlutterGalleryApp/states/profile/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileContainer extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.inProgress.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Column(
          children: [
            ProfileHeader(profile: profileController.profile.value),
          ],
        );
      }
    });
  }
}

class ProfileHeader extends StatelessWidget {
  final User profile;

  const ProfileHeader({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(profile.name),
        ],
      ),
    );
  }
}
