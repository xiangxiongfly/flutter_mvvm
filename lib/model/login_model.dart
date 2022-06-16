import 'package:mvvm_flutter/utils/dio_utils.dart';

class LoginModel {
  dynamic login(Map<String, String> map) async {
    return await post("https://www.wanandroid.com/user/login", map);
  }
}
