import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.key,
    this.likeCount,
    this.isLiked,
    this.name,
    this.userName,
    this.userPhoto,
    this.photo,
    this.altDescription,
    this.heroTag,
    this.routeSettings,
  });

  final int likeCount;
  final bool isLiked;
  final String name;
  final String userName;
  final String userPhoto;
  final String photo;
  final String altDescription;
  final String heroTag;
  final Key key;
  final RouteSettings routeSettings;
}

class FullScreenImage extends StatefulWidget {
  final int likeCount;
  final bool isLiked;
  final String name;
  final String userName;
  final String userPhoto;
  final String photo;
  final String altDescription;
  final String heroTag;

  const FullScreenImage(
      {Key key,
      this.likeCount = 0,
      this.isLiked = false,
      this.name,
      this.userName,
      this.userPhoto,
      this.photo,
      this.altDescription,
      this.heroTag})
      : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FullScreenAnimated(
      name: widget.name,
      userName: widget.userName,
      userAvatar: widget.userPhoto,
      photoLink: widget.photo,
      altDescription: widget.altDescription,
      likeCount: widget.likeCount,
      isLiked: widget.isLiked,
      heroTag: widget.heroTag,
      controller: _controller,
    );
  }
}

class FullScreenAnimated extends StatelessWidget {
  final int likeCount;
  final bool isLiked;
  final String name;
  final String userName;
  final String userAvatar;
  final String photoLink;
  final String altDescription;
  final String heroTag;

  final Animation<double> controller;
  final Animation<double> opacityAvatar;
  final Animation<double> opacityMetadata;

  FullScreenAnimated(
      {this.name = '',
      this.userName = '',
      this.userAvatar = '',
      this.photoLink = '',
      this.altDescription = '',
      this.likeCount = 0,
      this.isLiked = false,
      this.heroTag,
      this.controller,
      Key key})
      : opacityAvatar = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.ease,
            ),
          ),
        ),
        opacityMetadata = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: AnimatedBuilder(
        builder: _buildBody,
        animation: controller,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
                    ),
                    child: ClaimBottomSheet(),
                  );
                });
          },
          icon: Icon(Icons.more_vert),
          color: Colors.black,
        ),
      ],
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

  Widget _buildBody(BuildContext context, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Hero(
            tag: heroTag,
            child: PhotoWidget(
              photoLink: photoLink,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            altDescription,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(children: <Widget>[
            Opacity(
              opacity: opacityAvatar.value,
              child: UserAvatar(userAvatar),
            ),
            SizedBox(
              width: 6,
            ),
            Opacity(
              opacity: opacityMetadata.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    '${userName}',
                    style: Theme.of(context).textTheme.headline5.copyWith(color: AppColors.manatee),
                  )
                ],
              ),
            )
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 36,
              width: 105,
              child: Center(child: LikeButton(likeCount: likeCount, isLiked: isLiked)),
            ),
            Expanded(
              child: _buildButton('Save', () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Downloading photos'),
                          content: Text('Are you sure you want to upload a photo?'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  GallerySaver.saveImage(photoLink).then((bool success) {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text('Download')),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close')),
                          ],
                        ));
              }),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildButton(
                'Visit',
                () {},
              ),
            ),
          ],
        )
      ],
    );
  }

  GestureDetector _buildButton(String title, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
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
