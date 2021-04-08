import 'dart:io';

import 'package:agrotis/app/exceptions/bad_request_exception.dart';
import 'package:agrotis/app/exceptions/fetch_data_exception.dart';
import 'package:agrotis/app/exceptions/unauthorised_exception.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  static String baseUrl = "https://reboot-agrotis.herokuapp.com/";

  final Dio dio = new Dio();

  ApiService() {
    dio.options.baseUrl = baseUrl;
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return status < 500;
    };

    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 200000;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      print("Url===>$url");
      final response = await dio.get(baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {dynamic data}) async {
    var responseJson;
    try {
      print("Url===>$url,\n:Request===>${data?.toString()}");
      final response = await dio.post(baseUrl + url, data: data);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> fileUpload(String url, String filePath, String fileName,
      {Map<String, dynamic> data,
      String fileKey = "file",
      Function(int sent, int total) onProgress}) async {
    var responseJson;
    try {
      print("Request:${data?.toString()}");
      if (data == null) {
        data = Map();
      }
      data[fileKey] =
          await MultipartFile.fromFile(filePath, filename: fileName);

      FormData formData = FormData.fromMap(data);

      final response = await dio.post(baseUrl + url,
          data: formData, onSendProgress: onProgress);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    print(
        "Url===>${response.request.uri},\nResponse:==>${response?.data?.toString()}");
    switch (response?.statusCode) {
      case 200:
      case 201:
      case 404:
        print(response.data);
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response?.statusCode}');
    }
  }
}
