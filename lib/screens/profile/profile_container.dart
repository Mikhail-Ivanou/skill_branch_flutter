import 'package:FlutterGalleryApp/models/collection.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/models/user.dart';
import 'package:FlutterGalleryApp/models/extentions.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/states/profile/CollectionsController.dart';
import 'package:FlutterGalleryApp/states/profile/LikesController.dart';
import 'package:FlutterGalleryApp/states/profile/PhotosController.dart';
import 'package:FlutterGalleryApp/states/profile/ProfileController.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              ProfileHeader(profile: profileController.profile.value),
              ProfileContent(),
            ],
          ),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              UserAvatar(
                profile.profileImage.large,
                size: 75,
              ),
              SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(profile.followersCount.toString(),
                            style: const TextStyle(
                              color: AppColors.dodgerBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('followers', style: Theme.of(context).textTheme.headline5),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(profile.followingCount.toString(),
                            style: const TextStyle(
                              color: AppColors.dodgerBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('following', style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (profile.location != null)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 15,
                            color: AppColors.dodgerBlue,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              profile.location,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ],
                      ),
                    if (profile.portfolioUrl != null)
                      Row(
                        children: [
                          Icon(
                            Icons.link,
                            size: 15,
                            color: AppColors.dodgerBlue,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            profile.portfolioUrl,
                            style: Theme.of(context).textTheme.headline5,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (profile.bio != null)
            Text(
              profile.bio,
              style: Theme.of(context).textTheme.bodyText1,
            ),
        ],
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              labelColor: AppColors.dodgerBlue,
              unselectedLabelColor: Colors.black,
              indicatorColor: AppColors.dodgerBlue,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                ),
                Tab(
                    icon: Icon(
                  Icons.favorite_border_outlined,
                )),
                Tab(
                    icon: Icon(
                  Icons.assistant_outlined,
                )),
              ],
            ),
            Container(
              color: AppColors.lightGrey,
              height: 1,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ImagesList(),
                  LikesList(),
                  CollectionsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class ContentListWidget<T> extends StatelessWidget {
  final controller;

  const ContentListWidget({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.inProgress.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return GridView.builder(
            itemCount: controller.result.length,
            padding: EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index) {
              return buildCell(context, controller.result[index]);
            });
      }
    });
  }

  Widget buildCell(BuildContext context, T element);
}

class ImagesList extends ContentListWidget<Photo> {
  ImagesList() : super(controller: PhotosController(Get.put(ProfileController()).profile.value.username)..fetch());

  @override
  Widget buildCell(BuildContext context, Photo element) {
    return buildPhoto(context, element);
  }
}

Widget buildPhoto(BuildContext context, Photo element) {
  final item = element.toVm();
  final openPhotoDetail = () => Navigator.pushNamed(
        context,
        '/fullScreenImage',
        arguments: FullScreenImageArguments(
            photo: item.photoLink,
            altDescription: item.description,
            isLiked: item.isLiked,
            likeCount: item.likeCount,
            userName: item.userNickName,
            name: item.userName,
            userPhoto: item.userAvatar,
            heroTag: item.id,
            routeSettings: RouteSettings(
              arguments: 'Some title',
            )),
      );
  return GestureDetector(
    onTap: openPhotoDetail,
    child: Hero(
      tag: item.id,
      child: PhotoWidget(
        photoLink: element.urls.thumb,
      ),
    ),
  );
}

class LikesList extends ContentListWidget<Photo> {
  LikesList() : super(controller: LikesController(Get.put(ProfileController()).profile.value.username)..fetch());

  @override
  Widget buildCell(BuildContext context, Photo element) {
    return PhotoWidget(
      photoLink: element.urls.thumb,
    );
  }
}

class CollectionsList extends ContentListWidget<Collection> {
  CollectionsList()
      : super(controller: CollectionsController(Get.put(ProfileController()).profile.value.username)..fetch());

  @override
  Widget buildCell(BuildContext context, Collection element) {
    return PhotoWidget(
      photoLink: element.coverPhoto.urls.thumb,
    );
  }
}
