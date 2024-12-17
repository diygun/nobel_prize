import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            // const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            OverflowBar(
                alignment: MainAxisAlignment.start,
                children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: const Text("Register",
                      style: TextStyle(color: Colors.green)),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                    // Navigator.of(context).pop();
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
                    'NEXT',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
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
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'First Page',
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              child: Text('Go to second'),
              onPressed: () {
                Navigator.of(context).pushNamed('/second',
                    arguments: 'hello from the first page');

                // Pushing a route directly, WITHOUT using a named route
                // Navigator.of(context).push(
                //   // With MaterialPageRoute, you can pass data between pages,
                //   // but if you have a more complex app, you will quickly get lost.
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         SecondPage(data: 'Hello there from the first page!'),
                //   ),
                // );
              },
            )
          ],
        ),
      ),
    );
  }

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
}
