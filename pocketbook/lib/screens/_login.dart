import 'package:flutter/material.dart';
import 'package:pocketbook/screens/home.dart';
import 'package:pocketbook/screens/registeration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';

class LoginScreen extends StatefulWidget {
  final Isar isar;
  const LoginScreen({super.key, required this.isar});

  @override
  State<LoginScreen> createState() => _LoginScreenState(isar: isar);
}

class _LoginScreenState extends State<LoginScreen> {
  Isar isar;

  _LoginScreenState({required this.isar});

  @override
  void initState() {
    super.initState();
    loading = false;
    _checkIfLoggedIn();
  }

  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _password = "";
  bool loading = true;

  Future<void> _login() async {
    // get_auth_data
    // getAuthData(_username, _password).then((value) {
    //   if (value['error'] == 'false') {
    //     final authData = parseAuthData(value['content']!);
    //     setState(() {
    //       loading = false;
    //     });
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => AuthScreen(authData: authData),
    //         settings: const RouteSettings(name: 'AuthScreen'),
    //       ),
    //     );
    //   } else {
    //     setState(() {
    //       loading = false;
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(value['content']!),
    //       ),
    //     );
    //   }
    // });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            "ummm this isn't implemented yet, so i will allow you to pass"),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          title: 'HomeScreen',
          isar: isar,
        ),
        settings: const RouteSettings(name: 'HomeScreen'),
      ),
    );
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: // from web
                        NetworkImage(
                            "https://i.pinimg.com/originals/94/09/7e/94097e458fbb22184941be57aaab2c8f.png"),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        readOnly: loading,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              loading = false;
                            });
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) => _username = value!,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        readOnly: loading,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              loading = false;
                            });
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value!,
                        obscureText: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: !loading
                          ? ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurpleAccent,
                            )
                          : ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.grey,
                            ),
                      onPressed: () {
                        if (loading) {
                          return;
                        }
                        setState(() {
                          loading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _login();
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: const Text(
                        "New user? Register here",
                        style: TextStyle(
                            color: Color.fromARGB(255, 120, 120, 170)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkIfLoggedIn() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool('hasLoggedIn') ?? false) {
        // final authData = parseAuthData(prefs.getString('authdata')!);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              title: 'Homepage',
              isar: isar,
            ),
            settings: const RouteSettings(name: 'AuthScreen'),
          ),
        );
      }
    });
  }
}
