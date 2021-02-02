export 'photo.dart';
export 'user_avatar.dart';
export 'like_button.dart';
export 'claim_bottom_sheet.dart';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';
import 'user_avatar.dart';

class UserInfo extends StatelessWidget {
  UserInfo({this.userAvatar, this.userName, this.userNickname});

  final String userAvatar;
  final String userName;
  final String userNickname;

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
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '@$userNickname',
            style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.manatee),
          )
        ],
      )
    ]);
  }
}
