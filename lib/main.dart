import 'package:channab2day/add_animal.dart';
import 'package:channab2day/animal_list.dart';
import 'package:channab2day/sign_in.dart';
import 'package:channab2day/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:channab2day/userProfile.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(
      context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true,
    );
    return MaterialApp(initialRoute: 'Animal_list', routes: {
      'signin': (context) => SignIn(),
      'SignUp': (context) => SignUp(),
      'Add_animal': (context) => Add_animal(),
      'User_Profile': (context) => User_Profile(),
      'Animal_list': (context) => Animal_list(),
    });
  }
}
