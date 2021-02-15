import 'package:FlutterGalleryApp/res/res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  PhotoWidget({Key key, this.photoLink}) : super(key: key);

  final String photoLink;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 20;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(17)),
      child: Container(
        height: width,
        width: width,
        color: AppColors.grayChateau,
        child: CachedNetworkImage(
          imageUrl: photoLink,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover, //TODO fix ratio
        ),
      ),
    );
  }
}
