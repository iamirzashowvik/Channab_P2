import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'animal_list.dart';

List<int> sel = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var data;

  Map<String, String> body;
  @override
  Widget build(BuildContext context) {
    Color dc = Colors.white;
    return Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Animal Type',
                  style: TextStyle(fontSize: 100.h),
                ),
              ),
              Container(
                height: 150.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Diet_card(
                      name: 'Male',
                      color: dc,
                      c: 0,
                    ),
                    Diet_card(
                      name: 'Female',
                      color: dc,
                      c: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Status',
                  style: TextStyle(fontSize: 100.h),
                ),
              ),
              Container(
                height: 150.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Diet_card(
                      name: 'Active',
                      color: dc,
                      c: 2,
                    ),
                    Diet_card(
                      name: 'Retired',
                      color: dc,
                      c: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Female Status',
                  style: TextStyle(fontSize: 100.h),
                ),
              ),
              Container(
                height: 150.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Diet_card(
                      name: 'Milking',
                      color: dc,
                      c: 4,
                    ),
                    Diet_card(
                      name: 'Dry',
                      color: dc,
                      c: 5,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Animal Age',
                  style: TextStyle(fontSize: 100.h),
                ),
              ),
              Container(
                height: 150.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Diet_card(name: 'Less than 3 months', c: 6, color: dc),
                    Diet_card(name: 'Less than 6 months', c: 7, color: dc),
                    Diet_card(name: 'Less than 1 Year', c: 8, color: dc),
                    Diet_card(name: 'Less than 1.6 Year', c: 9, color: dc),
                    Diet_card(name: 'More than 1.6 Year', c: 10, color: dc),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  body = {
                    "Male": sel[0] == 1 ? "Male" : '',
                    "Female": sel[1] == 1 ? "Male" : '',
                    "active_status": sel[2] == 1 ? "Male" : '',
                    "retired_category": sel[3] == 1 ? "Male" : '',
                    "milking_status": sel[4] == 1 ? "Male" : '',
                    "dry_female_status": sel[5] == 1 ? "Male" : '',
                    "less_than_3_month": sel[6] == 1 ? "Male" : '',
                    "less_than_six": sel[7] == 1 ? "Male" : '',
                    "less_then_one": sel[8] == 1 ? "Male" : '',
                    "less_then_one_point_six": sel[9] == 1 ? "Male" : '',
                    "more_then_one_pont_six": sel[10] == 1 ? "Male" : '',
                    //"Female": "0"
                  };
                  // print('sel0 ${sel[0]}');
                  // final mineData = lookupMimeType(_selectedFile.path,
                  //     headerBytes: [0xFF, 0xD8]).split("/");
                  // var image = await http.MultipartFile.fromPath(
                  //     "main_image", _selectedFile.path,
                  //     contentType: MediaType(mineData[0], mineData[1]));
                  // SharedPreferences pref =
                  //     await SharedPreferences.getInstance();
//gg
//gg

                  // String url = "https://channab.com/api/search_listing/";
                  // Map<String, String> headers = <String, String>{
                  //   'token': "50a67c112aff02f32cfefd52c242933b727d28bd"
                  // };
                  // Map<String, String> requestBody = body;
                  // var uri = Uri.parse(url);
                  // var request = http.MultipartRequest('POST', uri)
                  //   ..headers.addAll(headers)
                  //   ..fields.addAll(requestBody);

                  // var res = await request.send();
                  // http.Response response = await http.Response.fromStream(res);
                  // data = json.decode(response.body);
                  // // print(data);
                  // if (response.statusCode == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Animal_list(
                              filter: body,
                            )),
                  );
                },
                child: Container(
                  height: 50,
                  margin:
                      EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Apply Filter",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Diet_card extends StatefulWidget {
  Diet_card({this.c, this.color, this.name});
  final String name;
  final Color color;
  final int c;
  @override
  _Diet_cardState createState() => _Diet_cardState();
}

class _Diet_cardState extends State<Diet_card> {
  bool isSelect = false;
  Color _color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelect = !isSelect;
          if (isSelect == true) {
            sel.insert(widget.c, 1);
          } else {
            sel.insert(widget.c, 0);
          }
        });
        print(isSelect);
      },
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          width: 300.0.w,
          height: 120.0.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: (isSelect) ? _color : Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0x0d130f10),
                offset: Offset(4, 6.928203105926514),
                blurRadius: 18,
              ),
            ],
          ),
          child: Center(
            child: TextResponsive(
              widget.name,
              style: TextStyle(
                fontSize: 40,
                color: (isSelect) ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
