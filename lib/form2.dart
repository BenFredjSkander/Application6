import 'dart:io';

import 'package:flutter/material.dart';
import 'loginData.dart';

class Page2 extends StatelessWidget {
  File pic;
  LoginData loginData;
  Page2({Key key, this.loginData, this.pic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final LoginData loginData = ModalRoute.of(context).settings.arguments["loginData"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Access Page'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(
                  pic,
                )),
            Text(
              'Welcome ${loginData.name}',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 20,
              ),
            ),
            Text('Your email is ${loginData.email}'),
            Text('your password is ${loginData.password}'),
            Text('Gouvernorat ${loginData.gov}'),
            BackButton(
              color: Colors.blue,
              onPressed: () => Navigator.pop(context, '/'),
            )
          ])),
    );
  }
}
