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
