import 'dart:convert';

import 'models/photo.dart';
import 'package:http/http.dart' as http;

const ACCESS_KEY = 'j-fq07oTND3_Eprp6pTEL_jxJkVgRP2m-SJILQYAmI4';
const SECRET_KEY = 'gKR68vAaMifaeCTNMED2-Xhi4qtDt-PNH25UkizqKtY';
const BASE_URL = 'https://api.unsplash.com/';
const HEADER = {'Authorization': 'Client-ID $ACCESS_KEY'};

class DataProvider {
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
    var response = await http.get(
        '${BASE_URL}photos?page=$page&per_page=$page_size',
        headers: HEADER);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return List<Photo>.from(decode.map((item) => Photo.fromJson(item)));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }

  static Future<List<Photo>> searchPhotos({
    String keyword,
    int page,
    int page_size,
  }) async {
    var response = await http.get(
        '${BASE_URL}/search/photos?query=$keyword&page=$page&per_page=$page_size',
        headers: HEADER);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      return Future.value(
          List<Photo>.from(decode.map((item) => Photo.fromJson(item))));
    } else {
      throw Exception("Couldn't get photos: ${response.reasonPhrase}");
    }
  }
}
