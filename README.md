[TOC]

# Flutter MVVM架构

## 概述

MVVM即 Model-View-ViewModel的缩写。

-   View层：显示界面。
-   Model层：数据请求、存储。
-   ViewModel：业务逻辑处理，连接View和Model层。



## 代码结构

![在这里插入图片描述](https://img-blog.csdnimg.cn/76ed58c7533849e9a371d2238ad99a8b.png)



## 具体实现

### 添加依赖库

```
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.3
  dio: ^4.0.6
```



### 简单封装网络请求框架

新建dio_utils.dart文件：

```dart
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
```



### 创建Model层

新建login_model.dart文件：

```dart
class LoginModel {
  dynamic login(Map<String, String> map) async {
    return await post("https://www.wanandroid.com/user/login", map);
  }
}
```



### 创建ViewModel层

```dart
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
    print(result.toString());
    setResult(result.toString());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```



### 创建View层

```dart
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel loginViewModel;

  @override
  void dispose() {
    loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MVVM学习"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("登陆功能"),
            TextField(
              controller: loginViewModel.usernameController,
              decoration: const InputDecoration(
                labelText: "用户名",
                prefixIcon: Icon(Icons.supervised_user_circle),
              ),
            ),
            TextField(
              controller: loginViewModel.passwordController,
              decoration: const InputDecoration(
                labelText: "密码",
                prefixIcon: Icon(Icons.verified_user),
              ),
              obscureText: true,
            ),
            OutlinedButton(
              onPressed: () {
                loginViewModel.setResult("");
                loginViewModel.login();
              },
              child: const Text("登陆"),
            ),
            Text(loginViewModel.result),
          ],
        ),
      ),
    );
  }
}
```



### 配色Provider状态管理

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM学习',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
    );
  }
}
```



### 最终效果

![在这里插入图片描述](https://img-blog.csdnimg.cn/13ecb4d2ace3468ca19280ed280ddb74.png)



