import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_project/navigation_screen.dart';
import 'package:app_project/screen/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_project/model/model_auth.dart';
import 'package:app_project/model/model_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              LoginForm(),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    '회원가입하기',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginModel, FirebaseAuthProvider>(
      builder: (context, loginModel, authProvider, _) {
        void _login() async {
          final String email = loginModel.email;
          final String password = loginModel.password;

          if (email.isNotEmpty && password.isNotEmpty) {
            AuthStatus status = await authProvider.loginWithEmail(email, password);
            if (status == AuthStatus.loginSuccess) {
              // Save login status and user information in SharedPreferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLogin', true);
              prefs.setString('email', email);

              // Navigate to the desired screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RootScreen()),
              );
            } else {
              // Login failed, show an error message
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('로그인 실패'),
                    content: Text('이메일과 비밀번호를 확인해주세요.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            }
          }
        }

        return Form(
          child: Column(
            children: [
              Consumer<LoginModel>(
                builder: (context, loginModel, _) {
                  return TextFormField(
                    onChanged: (value) {
                      loginModel.setEmail(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Consumer<LoginModel>(
                builder: (context, loginModel, _) {
                  return TextFormField(
                    onChanged: (value) {
                      loginModel.setPassword(value);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR,
                  ),
                  onPressed: _login,
                  child: Text(
                    '로그인',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
