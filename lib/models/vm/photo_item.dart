class PhotoItem {
  var id;
  String userName;
  String userNickName;
  String userAvatar;
  String photoLink;
  String description;

  int likeCount;
  bool isLiked;

  PhotoItem(
      {this.id,
        this.userName,
        this.userNickName,
        this.userAvatar,
        this.photoLink,
        this.description,
        this.likeCount,
        this.isLiked});
}
