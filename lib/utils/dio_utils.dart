import 'package:dio/dio.dart';

dynamic post(String url, Map<String, String> map) async {
  dynamic result = "";
  try {
    Response response = await Dio().post(url, queryParameters: map);
    result = response.data;
  } on DioError catch (e) {
    if (e.response != null) {
      result = "请求失败 ${e.response!.statusCode}";
    } else {
      result = "请求失败";
    }
  }
  return result.toString();
}
