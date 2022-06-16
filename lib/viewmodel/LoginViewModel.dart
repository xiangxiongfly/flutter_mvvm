import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter/model/login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginModel _loginModel = LoginModel();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  dynamic _result = "";

  TextEditingController get usernameController {
    return _usernameController;
  }

  TextEditingController get passwordController {
    return _passwordController;
  }

  dynamic get result {
    return _result;
  }

  setResult(dynamic data) {
    _result = data;
    notifyListeners();
  }

  login() async {
    dynamic result = await _loginModel.login({
      "username": _usernameController.text,
      "password": _passwordController.text,
    });
    setResult(result.toString());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
