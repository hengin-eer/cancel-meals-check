import 'package:cancel_meals_check/home_screen.dart';
import 'package:flutter/material.dart';
import 'google_login.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign In Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Googleサインインの関数を呼び出す
            final user = await signInWithGoogle();
            // サインインに成功した場合はホーム画面に遷移する
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
