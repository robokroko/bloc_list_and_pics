import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiRawData {
  final Dio _dio = Dio();

  ApiRawData() {
    _dio.options.baseUrl = "http://dev.tapptic.com/test/json.php";
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}
