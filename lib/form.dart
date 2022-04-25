import 'dart:io';

import 'package:Application6/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'loginData.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  LoginData loginData = LoginData();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController govController = new TextEditingController();

  File _imageFile;
  ImagePicker imagePicker;

  _pickImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_rounded),
            onPressed: () => {
              nameController.clear(),
              emailController.clear(),
              passwordController.clear(),
              govController.clear(),
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                _imageFile == null
                    ? Stack(
                        children: [
                          CircleAvatar(
                              radius: 80,
                              backgroundColor: Color(0xfff1f1f1),
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.lightBlue,
                                  size: 100.0,
                                ),
                              )),
                          Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: InkWell(
                                  child: Icon(Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                  onTap: () => _pickImage()))
                        ],
                      )
                    : Stack(
                        children: [
                          CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(
                                _imageFile,
                              )),
                          Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: InkWell(
                                  child: Icon(Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                  onTap: () => _pickImage()))
                        ],
                      ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else
                        loginData.name = value;
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypeAheadFormField(
                    getImmediateSuggestions: true,
                    // suggestionsBoxController: _suggestionsBoxController,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: govController,
                      decoration: InputDecoration(
                        hintText: "Gouvernorat",
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return getSuggestions(pattern);
                    },
                    itemBuilder: (context, String suggestion) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          suggestion,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                    onSuggestionSelected: (String suggestion) {
                      govController.text = suggestion;
                    },
                    validator: (value) =>
                        (value.isEmpty || !kGov.contains(value))
                            ? 'Incorrect gouvernorat'
                            : null,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    validator: (val) => !EmailValidator.validate(val)
                        ? 'Not a valid email.'
                        : null,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else
                        loginData.password = value;
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      onPrimary: Colors.white,
                      shadowColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      elevation: 5,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        loginData = LoginData(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            gov: govController.text);
                        Navigator.pushNamed(context, '/second',
                            arguments: loginData);
                      }
                    },
                    child:
                        Text('Log In', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(kGov);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
