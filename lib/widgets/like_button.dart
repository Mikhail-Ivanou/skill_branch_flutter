import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:flutter/widgets.dart';

class LikeButton extends StatefulWidget {
  LikeButton(this.likeCount, this.isLiked);

  final int likeCount;
  final bool isLiked;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            likeCount++;
          } else {
            likeCount--;
          }
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
              SizedBox(
                width: 4,
              ),
              Text(likeCount.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
