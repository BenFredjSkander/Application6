import 'package:flutter/material.dart';
import 'loginData.dart';
class Page2 extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    final LoginData loginData=ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
          appBar: AppBar(
            title: Text('Access Page'),
          ),
          body: Center(
              child :  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      Icon(Icons.person,
                      color: Colors.blueAccent,
                      size: 200.0,
                        semanticLabel: 'Add your profile photo',
                    ),
                    Text('Welcome ${loginData.name}',style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                    ),),
                    Text('Your email is ${loginData.email}'),
                    Text('your password is ${loginData.password}'),
                    Text('Gouvernorat ${loginData.gov}'),
                    BackButton(
                      color:Colors.blue,
                      onPressed: ()=>Navigator.pop(context,'/'),
                    )
                  ]
              )
          )
      ),
    );
  }
}