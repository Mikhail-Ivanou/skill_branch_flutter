import 'dart:convert';

import 'package:FlutterGalleryApp/models/collection.dart';
import 'package:FlutterGalleryApp/models/photo.dart';
import 'package:FlutterGalleryApp/models/user.dart';
import 'package:flutter/material.dart';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

const ACCESS_KEY = 'j-fq07oTND3_Eprp6pTEL_jxJkVgRP2m-SJILQYAmI4';
const SECRET_KEY = 'gKR68vAaMifaeCTNMED2-Xhi4qtDt-PNH25UkizqKtY';
const BASE_URL = 'https://api.unsplash.com/';
const HEADER = {'Authorization': 'Client-ID $ACCESS_KEY'};

class DataProvider {
  static String token;

  static Future<String> getAuthToken() async {
    final baseAuthUrl = 'https://unsplash.com/oauth/authorize';
    final callbackUrlScheme = 'photoapp';
    final redirectUrl = Uri.parse('photoapp://callback');
    final scope = 'public+write_likes';

    final url = '$baseAuthUrl?client_id=$ACCESS_KEY&redirect_uri=$redirectUrl&response_type=code&scope=$scope';
    final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: callbackUrlScheme);
    final String code = Uri.parse(result).queryParameters['code'];
    final baseTokenUrl = 'https://unsplash.com/oauth/token';
    final body = {
      'client_id': ACCESS_KEY,
      'client_secret': SECRET_KEY,
      'redirect_uri': 'photoapp://callback',
      'code': code,
      'grant_type': 'authorization_code',
    };
    try {
      var response = await http.post(
        baseTokenUrl,
        body: body,
      );
      return jsonDecode(response.body)['access_token'];
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Photo> getPhoto(String id) async {
    var response = await http.get('${BASE_URL}photos/$id', headers: HEADER);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return Future.value(Photo.fromJson(decode));
    } else {
      throw Exception("Couldn't get photo: ${response.reasonPhrase}");
    }
  }

  static Future<List<Photo>> getPhotos({
    int page,
    int page_size,
  }) async {
    var response = await http.get('${BASE_URL}photos?page=$page&per_page=$page_size', headers: HEADER);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return List<Photo>.from(decode.map((item) => Photo.fromJson(item)));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }

  static Future<List<Photo>> getPhotosByUser({
    @required String userName,
    int page,
    int pageSize,
  }) async {
    var url = '${BASE_URL}users/$userName/photos?page=$page&per_page=$pageSize';
    return _getContentByUser(userName: userName, url: url, page: page, pageSize: pageSize);
  }

  static Future<List<Photo>> getLikesByUser({
    @required String userName,
    int page,
    int pageSize,
  }) async {
    var url = '${BASE_URL}users/$userName/likes?page=$page&per_page=$pageSize';
    return _getContentByUser(userName: userName, url: url, page: page, pageSize: pageSize);
  }

  static Future<List<Collection>> getCollectionsByUser({
    @required String userName,
    int page,
    int pageSize,
  }) async {
    var url = '${BASE_URL}users/$userName/collections?page=$page&per_page=$pageSize';
    return _getCollectionsByUser(userName: userName, url: url, page: page, pageSize: pageSize);
  }

  static Future<List<Photo>> _getContentByUser({
    @required String userName,
    @required String url,
    int page,
    int pageSize,
  }) async {
    var response = await http.get(url, headers: HEADER);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return List<Photo>.from(decode.map((item) => Photo.fromJson(item)));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }

  static Future<List<Collection>> _getCollectionsByUser({
    @required String userName,
    @required String url,
    int page,
    int pageSize,
  }) async {
    var response = await http.get(url, headers: HEADER);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return List<Collection>.from(decode.map((item) => Collection.fromJson(item)));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }

  static Future<List<Photo>> searchPhotos({
    String keyword,
    int page,
    int page_size,
  }) async {
    var response =
        await http.get('${BASE_URL}/search/photos?query=$keyword&page=$page&per_page=$page_size', headers: HEADER);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return Future.value(List<Photo>.from(decode.map((item) => Photo.fromJson(item))));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }

  static Future<User> getProfile() async {
    if (token == null || token.isEmpty) {
      return null;
    }
    final authed = {'Authorization': 'Bearer $token'};
    var response = await http.get('${BASE_URL}me', headers: authed);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return User.fromJson(decode);
    } else {
      throw Exception("Couldn't get profile: ${response.reasonPhrase}");
    }
  }
}
