import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';
const String kHeroTag = 'heroTag';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    PhotoItem item = PhotoItem(
        userAvatar:
            'https://sun9-3.userapi.com/c5779/u156848426/d_71759ad9.jpg',
        userName: 'Mike Ivanou',
        userNickName: '@MikeIvanou',
        photoLink: kFlutterDash,
        description: 'This is Flutter dash, I love him :)',
        likeCount: 10,
        isLiked: true);
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                _buildItem(context, item, index),
                Divider(
                  thickness: 2,
                  color: AppColors.mercury,
                ),
              ],
            );
          }),
    );
  }
}

Widget _buildItem(BuildContext context, PhotoItem item, int index) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
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
          heroTag: kHeroTag + index.toString(),
          routeSettings: RouteSettings(
            arguments: 'Some title',
          )),

//      context,
//      MaterialPageRoute(
//          builder: (context) => FullScreenImage(
//                photo: item.photoLink,
//                altDescription: item.description,
//                isLiked: item.isLiked,
//                likeCount: item.likeCount,
//                userName: item.userNickName,
//                name: item.userName,
//                userPhoto: item.userAvatar,
//                heroTag: kHeroTag + index.toString(),
//              )),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: kHeroTag + index.toString(),
          child: Photo(
            photoLink: item.photoLink,
          ),
        ),
        _buildPhotoMeta(item),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            item.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3,
          ),
        )
      ],
    ),
  );
}

Widget _buildPhotoMeta(PhotoItem item) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        UserInfo(
            userAvatar: item.userAvatar,
            userName: item.userName,
            userNickname: item.userNickName),
        LikeButton(likeCount: 10, isLiked: true)
      ],
    ),
  );
}

class PhotoItem {
  PhotoItem(
      {this.userName,
      this.userNickName,
      this.userAvatar,
      this.photoLink,
      this.description,
      this.likeCount,
      this.isLiked});

  String userName;
  String userNickName;
  String userAvatar;
  String photoLink;
  String description;

  int likeCount;
  bool isLiked;
}
