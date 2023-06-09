import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pocketbook/screens/home.dart';
import 'package:isar/isar.dart';

class LoginScreen extends StatefulWidget {
  final Isar isar;

  LoginScreen({super.key, required this.isar});

  @override
  State<StatefulWidget> createState() => _LoginScreen(isar: isar);
}

class _LoginScreen extends State<LoginScreen> {
  Isar isar;

  _LoginScreen({required this.isar});

  @override
  Widget build(BuildContext context) {
    final auth = LocalAuthentication();
    tryAuthenticate(auth).then((didAuthenticate) {
      if (didAuthenticate) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: APP_TITLE, isar: isar,),
          ),
        );
      } else {
        SystemNavigator.pop();
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Authenticating..."),
          ],
        ),
      ),
    );
  }

  Future<bool> tryAuthenticate(LocalAuthentication auth) async {
    // simply try to do device authentication,
    // if it fails or attempts are exhausted,
    // just exit the app.
    try {
      final didAuthenticate = await auth.authenticate(
        localizedReason:
            "We care about data that should be private to you. Please authenticate.",
        options: const AuthenticationOptions(stickyAuth: true),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(
            "OOPS! We're running on an unsupported platform (either Android version is too old or we're on Web/Linux)");
        print(e);
      }
      return Future.delayed(const Duration(seconds: 0), () => false);
    }
  }
}
