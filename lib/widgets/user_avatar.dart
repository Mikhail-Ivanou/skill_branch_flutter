import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar(this.avatarLink, {this.size});

  final String avatarLink;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size ?? 40),
      child: CachedNetworkImage(
        imageUrl: avatarLink,
        width: size ?? 40,
        height: size ?? 40,
        fit: BoxFit.fill,
      ),
    );
  }
}
