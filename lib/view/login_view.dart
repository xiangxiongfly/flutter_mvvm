import 'package:flutter/material.dart';
import 'package:mvvm_flutter/viewmodel/LoginViewModel.dart';
import 'package:provider/provider.dart';

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
