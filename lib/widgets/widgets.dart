export 'photo.dart';
export 'user_avatar.dart';
export 'like_button.dart';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';
import 'user_avatar.dart';

class UserInfo extends StatelessWidget {
  UserInfo({this.userAvatar, this.userName, this.userNickname});

  String userAvatar;
  String userName;
  String userNickname;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      UserAvatar(userAvatar),
      SizedBox(
        width: 6,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            userName,
            style: AppStyles.h2Black,
          ),
          Text(
            userNickname,
            style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
          )
        ],
      )
    ]);
  }
}
