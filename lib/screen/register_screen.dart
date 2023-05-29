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
            title: Text('Error'),
            content: Text('Passwords do not match.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Perform registration logic here
      // ...

      // Register user using Firebase Auth
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        // Registration successful
        print('Registration successful');

        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }).catchError((error) {
        // Registration failed
        print('Registration failed: $error');

        // Handle registration error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Registration failed: $error'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
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
        title: Text('Membership Registration'),
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
              _buildTextField(_emailController, 'Email'),
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
