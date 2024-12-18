import 'package:flutter/material.dart';
import 'db_access.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

// TO DO : Check users

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quitter Nobel Prize?'),
          content: const Text(
            'Voulez-vous vraiment quitter Nobel Prize?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Quitter', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _userExists(String username, String password) async {
    try {
      return await _dbHelper.userExists(username, password);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),
              Column(
                children: <Widget>[
                  Text('Nobel Prize', style: TextStyle(fontSize: 50)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text('Login', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
              // const SizedBox(height: 120.0),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUnfocus,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              // const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUnfocus,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                obscureText: true,
              ),
              Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        child: const Text("Register",
                            style: TextStyle(color: Colors.green)),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                  Expanded(
                    child: TextButton(
                      child: const Text("RESET FORM",
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        _usernameController.clear();
                        _passwordController.clear();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text("CLEANE DB",
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        _dbHelper.clearDatabase();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text("SHOW DB",
                          style: TextStyle(color: Colors.lightGreen)),
                      onPressed: () {
                        _dbHelper.showDatabase();
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: const Text(
                      'NEXT',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print("entering...");
                        if (await _userExists(_usernameController.text, _passwordController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('User added successfully!')));
                          Navigator.of(context).pushNamed('/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Incorrect username or password',
                                      style: TextStyle(color: Colors.red))));
                        }
                      }
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
              PopScope<Object?>(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, Object? result) async {
                  if (didPop) {
                    return;
                  }
                  final bool shouldPop = await _showBackDialog() ?? false;
                  if (context.mounted && shouldPop) {
                    Navigator.pop(context);
                  }
                },
                child: Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
