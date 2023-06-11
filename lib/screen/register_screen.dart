import 'package:flutter/material.dart';
import 'package:app_project/const/colors.dart';
import 'package:app_project/screen/login_screen.dart';
import 'package:app_project/model/model_auth.dart';
import 'package:app_project/model/model_register.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _register() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // Print the entered values
    print('Email: $email');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');

    if (password != confirmPassword) {
      // Passwords do not match
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('비밀번호가 일치하지 않습니다.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: MAIN_COLOR, // Change the button color to red
                ),
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      // Password length is less than 6 characters
      if (password.length < 6) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('오류'),
              content: Text('비밀번호는 6자 이상이어야 합니다.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR, // Change the button color to red
                  ),
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
        return; // Return from the function to prevent further execution
      }

      // Perform registration logic here
      // ...

      // Register user using Firebase Auth
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        // Registration successful
        print('회원가입이 완료되었습니다.');

        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }).catchError((error) {
        // Registration failed
        print('회원가입에 실패하였습니다: $error');

        String errorMessage = '';

        if (error.code == 'invalid-email') {
          errorMessage = '이메일 형식이 올바르지 않습니다.';
        } else {
          errorMessage = '회원가입에 실패하였습니다: $error';
        }

        // Handle registration error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('오류'),
              content: Text(errorMessage),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR, // Change the button color to red
                  ),
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('회원가입', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              _buildTextField(_emailController, '이메일'),
              SizedBox(height: 10),
              _buildTextField(_passwordController, '비밀번호', obscureText: true),
              SizedBox(height: 10),
              _buildTextField(_confirmPasswordController, '비밀번호 확인', obscureText: true),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR,
                  ),
                  onPressed: _register,
                  child: Text(
                    '회원가입',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
