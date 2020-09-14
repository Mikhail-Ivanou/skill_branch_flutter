import 'dart:io';

import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'res/res.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: buildAppTextTheme()),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments arguments =
              settings.arguments as FullScreenImageArguments;
          final route = FullScreenImage(
            photo: arguments.photo,
            userName: arguments.userName,
            isLiked: arguments.isLiked,
            userPhoto: arguments.userPhoto,
            likeCount: arguments.likeCount,
            altDescription: arguments.altDescription,
            heroTag: arguments.heroTag,
            name: arguments.name,
            key: arguments.key,
          );
          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route, settings: arguments.routeSettings);
          } else {
            return CupertinoPageRoute(builder: (context) => route);
          }
        }
      },
      home: Home(Connectivity().onConnectivityChanged),
    );
  }
}
