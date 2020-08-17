import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final int likeCount;
  final bool isLiked;
  final String name;
  final String userName;
  final String userAvatar;
  final String photoLink;
  final String altDescription;

  FullScreenImage(
      {this.name = '',
      this.userName = '',
      this.userAvatar = '',
      this.photoLink = '',
      this.altDescription = '',
      this.likeCount = 0,
      this.isLiked = false,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(CupertinoIcons.back),
        color: Colors.black,
      ),
      title: Text(
        'Photo',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Photo(
          photoLink: photoLink,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            altDescription,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: UserInfo(
              userAvatar: userAvatar, userName: name, userNickname: '@$userName'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 36,
              width: 105,
              child: Center(child: LikeButton(likeCount, isLiked)),
            ),
            _buildButton('Save'),
            _buildButton('Visit'),
          ],
        )
      ],
    );
  }

  GestureDetector _buildButton(String title) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 36,
        width: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: AppColors.dodgerBlue,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
