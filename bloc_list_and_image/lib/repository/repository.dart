import 'dart:async';
import 'dart:convert';

import 'package:bloc_list_and_image/models/image_raw_data.dart';
import 'package:bloc_list_and_image/models/image_details.dart';
import 'package:bloc_list_and_image/repository/api/api_details.dart';
import 'package:bloc_list_and_image/repository/api/api_raw_data.dart';
import 'package:dio/dio.dart';

class Repository {
  ApiRawData apiRawData = ApiRawData();
  ApiDetails apiDetails = ApiDetails();

  Future<List<ImageRawData>> fetchImageRawDatas() async {
    try {
      Response response = await ApiRawData().sendRequest.get("/get");
      final imagesJson = jsonDecode(response.data);
      List<ImageRawData> images = List<ImageRawData>.from(imagesJson.map((model) => ImageRawData.fromJson(model)));
      return images;
    } catch (ex) {
      throw Exception('Failed to fetch ImageRawDatas');
    }
  }

  Future<ImageDetails> fetchImageDetails(String name) async {
    try {
      Response response = await ApiDetails().sendRequest.get('http://dev.tapptic.com/test/json.php', queryParameters: {'name': name});
      final imagDetailJson = jsonDecode(response.data);
      ImageDetails imagDetails = ImageDetails.fromJson(imagDetailJson);
      return imagDetails;
    } catch (ex) {
      throw Exception('Failed to fetch ImageDetails');
    }
  }

  void fetchImageDataList() {}
}
