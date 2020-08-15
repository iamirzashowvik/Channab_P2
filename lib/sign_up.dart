import 'dart:convert';

import 'package:channab2day/add_animal.dart';
import 'package:channab2day/userProfile.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:dio/dio.dart';

import 'sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name;
  String phn;
  String pass;
  String userToken;
  bool obs = true;
  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(
      context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );
    return ResponsiveWidgets.builder(
        height: 1920, // Optional
        width: 1080, // Optional
        allowFontScaling: true,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Welcome to Channab',
                  style: TextStyle(
                      fontSize: 75,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Let\'s create your Channab account',
                  style: TextStyle(fontSize: 60, color: Colors.green),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.email),
                      ),
                      Flexible(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.phone_android),
                      ),
                      Flexible(
                        child: TextField(
                          keyboardType:
                              TextInputType.numberWithOptions(signed: true),
                          onChanged: (value) {
                            setState(() {
                              phn = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            prefix: CountryCodePicker(
                              onChanged: print,

                              initialSelection: 'PK',

                              // optional. Shows only country name and flag
                              showCountryOnly: true,
                              //   // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              //   // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.lock_outline),
                      ),
                      Flexible(
                        child: TextField(
                          obscureText: obs,
                          onChanged: (value) {
                            setState(() {
                              pass = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (obs == true) {
                                      obs = false;
                                    } else {
                                      obs = true;
                                    }
                                  });
                                },
                                child: Icon(Icons.remove_red_eye)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    FormData formData = new FormData.fromMap({
                      "email": name,
                      "password": pass,
                      "mobile_number": phn
                    });
                    Dio dio = Dio();
                    Response response = await dio.post(
                        "https://channab.com/api/register/",
                        data: formData,
                        options: Options(headers: {
                          "x-api-key":
                              "9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b"
                        }));
                    print(response.data);
                    var jsonResponse = json.decode(response.data);
                    var status = jsonResponse['status'];
                    print(status);
                    if (status == 200) {
                      userToken = jsonResponse['token'];
                      print(jsonResponse['token']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignIn(tokeen: userToken)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: Center(
                        child: TextResponsive(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 150.h),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextResponsive(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      child: TextResponsive(
                        '  Sign In',
                        style: TextStyle(fontSize: 45, color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
