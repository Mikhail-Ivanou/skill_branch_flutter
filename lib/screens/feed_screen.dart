import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/models/extentions.dart';
import 'package:FlutterGalleryApp/models/vm/photo_item.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<PhotoItem> items = [];
  ScrollController _controller;
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
        if (!isLoading) {
          _loadFeed(page: ++currentPage);
        }
      }
    });
    _loadFeed(page: currentPage);
    super.initState();
  }

  void _loadFeed({int page, bool clear = false}) async {
    setState(() {
      isLoading = true;
    });
    List<Photo> result = await DataProvider.getPhotos(page: page, page_size: 20);
    setState(() {
      isLoading = false;
      if (clear == true) {
        items.clear();
      }
      items.addAll(result.map((item) => item.toVm()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(children: [
                RefreshIndicator(
                  onRefresh: () async {
                    currentPage = 1;
                    _loadFeed(page: currentPage, clear: true);
                  },
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            _buildItem(context, items[index], index),
                            Divider(
                              thickness: 2,
                              color: AppColors.mercury,
                            ),
                          ],
                        );
                      },
                      controller: _controller,
                    ),
                  ),
                ),
                _getProgress()
              ]),
            ),
    );
  }

  Widget _getProgress() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: isLoading
            ? LinearProgressIndicator(
                minHeight: 6,
                backgroundColor: AppColors.dodgerBlue,
              )
            : Container());
  }
}

Widget _buildItem(BuildContext context, PhotoItem item, int index) {
  var openPhotoDetail = () => Navigator.pushNamed(
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      GestureDetector(
        onTap: openPhotoDetail,
        child: Hero(
          tag: item.id,
          child: PhotoWidget(
            photoLink: item.photoLink,
          ),
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
  );
}

Widget _buildPhotoMeta(PhotoItem item) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        UserInfo(userAvatar: item.userAvatar, userName: item.userName, userNickname: item.userNickName),
        LikeButton(likeCount: item.likeCount, isLiked: item.isLiked)
      ],
    ),
  );
}
