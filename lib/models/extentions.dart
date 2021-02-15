import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/models/vm/photo_item.dart';

extension ModelVm on Photo {
  PhotoItem toVm() {
    return PhotoItem(
        id: id,
        userAvatar: user.profileImage?.small ?? '',
        userName: '${user.firstName ?? ''} ${user.lastName ?? ''}',
        userNickName: user.name ?? '',
        photoLink: urls.small ?? '',
        description: description ?? '',
        likeCount: likes,
        isLiked: likedByUser);
  }
}
