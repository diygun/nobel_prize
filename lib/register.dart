import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatedController = TextEditingController();

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
                  child: Text('Register', style: TextStyle(fontSize: 20)),
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

            // const SizedBox(height: 120.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            // const SizedBox(height: 12.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUnfocus,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordRepeatedController,
              decoration: const InputDecoration(
                labelText: 'Repeat Password',
              ),
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUnfocus,
              obscureText: true,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _passwordController.text) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            OverflowBar(alignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: const Text("Login",
                      style: TextStyle(color: Colors.green)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ]),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: const Text("RESET FORM",
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      Navigator.of(context).pushNamed('/home');
                      // Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
