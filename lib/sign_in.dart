import 'dart:convert';
import 'package:channab2day/animal_list.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'add_animal.dart';
import 'sign_up.dart';
import 'animal_details.dart';

class SignIn extends StatefulWidget {
  final String tokeen;
  SignIn({this.tokeen});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obs = true;
  String phone;
  String pass;
  String userToken;
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
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 300,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //       image: ExactAssetImage(
                    //           'Assets/photo6154419738822945223.jpg'),
                    //       fit: BoxFit.cover),
                    // ),
                  ),
                  Positioned(
                    top: 15,
                    right: 0,
                    child: Container(
                        height: 90.h,
                        width: 90.h,
                        color: Colors.white,
                        child: Center(
                          child: TextResponsive(
                            'Skip',
                            style: TextStyle(fontSize: 35),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextResponsive(
                'Welcome Back',
                style: TextStyle(
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextResponsive(
                'Sign in your Channab account',
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
                      child: Icon(Icons.phone_android),
                    ),
                    Flexible(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true),
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          // prefix: CountryCodePicker(
                          //   onChanged: print,

                          //   initialSelection: 'PK',

                          //   // optional. Shows only country name and flag
                          //   showCountryOnly: false,
                          //   // optional. Shows only country name and flag when popup is closed.
                          //   showOnlyCountryWhenClosed: false,
                          //   // optional. aligns the flag and the Text left
                          //   alignLeft: false,
                          // ),
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
                          pass = value;
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
                    "mobile_number": phone,
                    "password": pass,
                  });
                  Dio dio = Dio();
                  Response response = await dio.post(
                      "https://channab.com/api/login/",
                      data: formData,
                      options: Options(headers: {
                        "x-api-key": "9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b"
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
                          builder: (context) => Animal_details(
                                token: userToken,
                              )),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
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
                    'Sign In',
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
                    'Don\'t I have an account?',
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: TextResponsive(
                      '  Sign Up',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
