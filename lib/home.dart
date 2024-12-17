import 'package:flutter/material.dart';
import 'package:nobel_prize/routegenerator.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Text(
            //   'Home',
            //   style: TextStyle(fontSize: 50),
            // ),
            ElevatedButton(
              child: Text('Se deconneceter'),
              onPressed: () {
                // Navigator.of(context).pushNamed('/');
                Navigator.pop(context);

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
}
