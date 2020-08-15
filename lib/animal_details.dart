import 'dart:io';
import 'dart:convert';
import 'package:channab2day/model/activeS_AD.dart';
import 'package:channab2day/model/ad_tab_Data.dart';
import 'package:channab2day/model/char_card.dart';
import 'package:http/http.dart' as http;
import 'package:channab2day/add_animal.dart';
import 'model/del/del_health.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'model/ADTab2.dart';
//import 'package:flutter_multiselect/flutter_multiselect.dart';

class Animal_details extends StatefulWidget {
  final String token;
  Animal_details({this.token});
  @override
  _Animal_detailsState createState() => _Animal_detailsState();
}

class _Animal_detailsState extends State<Animal_details>
    with SingleTickerProviderStateMixin {
  String id = "64";
  showAlertDialog4(BuildContext context) {
    // set up the list options
    String des;
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Add Description'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Add Description'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              des = value;
            },
          ),
        ),
        GestureDetector(
          onTap: () async {
            Map<String, String> body = {
              "animal_particular_id": id,
              "description": des
            };

            SharedPreferences pref = await SharedPreferences.getInstance();
            String url = "https://channab.com/api/description_popup/";
            Map<String, String> headers = <String, String>{
              'token': widget.token
            };
            Map<String, String> requestBody = body;
            var uri = Uri.parse(url);
            var request = http.MultipartRequest('POST', uri)
              ..headers.addAll(headers)
              ..fields.addAll(requestBody);

            var res = await request.send();
            http.Response response = await http.Response.fromStream(res);
            var data = json.decode(response.body);
            print(data);
            if (response.statusCode == 200) {
              setState(() {
                // i = 1;
                //Navigator.pop(context);
              });
            } else {
              setState(() {
                // i = 0;
              });
            }
          },
          child: Char_card(name: 'Save Information', cc: Colors.blueAccent),
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  static const TextStyle optionStyle = TextStyle(
    fontSize: 35,
    //  color: const Color(0x4d130f10),
  );
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String kIanimaltag;
  String kIcoP;
  String kIage;
  String kIgender;
  String kIcurentType;
  String kIbreed;
  String kIdop;
  showAlertDialog5(BuildContext context) {
    int i = 0;
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Edit Animal'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Animal Tag'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(hintText: kIanimaltag),
            onChanged: (value) {
              kIanimaltag = value;
              print(kIanimaltag);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Age'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: kIage == null ? Container() : Text(kIage),
            trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100))
                      .then((date) {
                    setState(() {
                      kIage = date.toString().split(" ")[0];
                      showAlertDialog5(context);
                      print(kIage);
                    });
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: TextResponsive(
              'Gender',
              style: TextStyle(
                fontSize: 120.h,
              ),
            ),
            trailing: DropdownButton(
                hint: TextResponsive(
                  'Gender',
                  style: TextStyle(
                    fontSize: 120.h,
                  ),
                ),
                underline: Container(),
                value: kIgender,
                items: [
                  DropdownMenuItem(
                    child: Text("Male"),
                    value: "Male",
                  ),
                  DropdownMenuItem(
                    child: Text("Female"),
                    value: "Female",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    kIgender = value;
                    showAlertDialog5(context);
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: TextResponsive(
              'Animal Type',
              style: TextStyle(
                fontSize: 120.h,
              ),
            ),
            trailing: DropdownButton(
                hint: TextResponsive(
                  'Type',
                  style: TextStyle(
                    fontSize: 120.h,
                  ),
                ),
                underline: Container(),
                value: kIcurentType,
                items: [
                  DropdownMenuItem(
                    child: Text("Pregnant/Milking"),
                    value: "Pregnant/Milking",
                  ),
                  DropdownMenuItem(
                    child: Text("Pregnant"),
                    value: "Pregnant",
                  ),
                  DropdownMenuItem(
                    child: Text("Dry"),
                    value: "Dry",
                  ),
                  DropdownMenuItem(
                    child: Text("Milking"),
                    value: "Milking",
                  ),
                  DropdownMenuItem(
                    child: Text("None"),
                    value: "None",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    kIcurentType = value;
                    showAlertDialog5(context);
                    // print(currentCat);
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: TextResponsive(
              'Animal Breed',
              style: TextStyle(
                fontSize: 120.h,
              ),
            ),
            trailing: DropdownButton(
                hint: TextResponsive(
                  'Animal Breed',
                  style: TextStyle(
                    fontSize: 120.h,
                  ),
                ),
                underline: Container(),
                value: kIbreed,
                items: [
                  DropdownMenuItem(
                    child: Text("Automatic"),
                    value: "Automatic",
                  ),
                  DropdownMenuItem(
                    child: Text("Manual"),
                    value: "Manual",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    kIbreed = value;
                    showAlertDialog5(context);
                  });
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Cost Of Purchase'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: kIcoP,
            ),
            onChanged: (value) {
              setState(() {
                kIcoP = value;
                //showAlertDialog5(context);
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Date of Purchase'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: kIdop == null ? Container() : Text(kIdop),
            trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100))
                      .then((date) {
                    setState(() {
                      kIdop = date.toString().split(" ")[0];
                      showAlertDialog5(context);
                      print(kIdop);
                    });
                  });
                }),
          ),
        ),
        getImageWidget5(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                  color: Colors.green,
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    getImage5(ImageSource.camera);
                  }),
              MaterialButton(
                  color: Colors.deepOrange,
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    getImage5(ImageSource.gallery);
                  }),
            ]),
        GestureDetector(
          onTap: () async {
            http.Response response;
            Map<String, String> body = {
              "animal_tag": kIanimaltag,
              "animal_particular_id": id, //this need to dynamic
              "age": kIage,
              "animal_bread": kIbreed,
              "gender": kIgender,
              "animal_type": kIcurentType,
              "cost_purchase": kIcoP == null ? '' : kIcoP,
              "date_of_purchase": kIdop == null ? '' : kIdop,
            };
            if (tap == 0) {
              SharedPreferences pref = await SharedPreferences.getInstance();
              String url = "https://channab.com/api/main_animal_info_update/";
              Map<String, String> headers = <String, String>{
                'token': widget.token
              };
              Map<String, String> requestBody = body;
              var uri = Uri.parse(url);
              var request = http.MultipartRequest('POST', uri)
                ..headers.addAll(headers)
                ..fields.addAll(requestBody);

              var res = await request.send();
              response = await http.Response.fromStream(res);
            } else {
              final mineData =
                  lookupMimeType(path5, headerBytes: [0xFF, 0xD8]).split("/");
              print(path5);
              var image = await http.MultipartFile.fromPath("main_image", path5,
                  contentType: MediaType(mineData[0], mineData[1]));
              SharedPreferences pref = await SharedPreferences.getInstance();
              String url = "https://channab.com/api/main_animal_info_update/";
              Map<String, String> headers = <String, String>{
                'token': widget.token
              };
              Map<String, String> requestBody = body;
              var uri = Uri.parse(url);
              var request = http.MultipartRequest('POST', uri)
                ..headers.addAll(headers)
                ..files.add(image)
                ..fields.addAll(requestBody);

              var res = await request.send();
              response = await http.Response.fromStream(res);
            }

            var data = json.decode(response.body);
            print(data);

            if (response.statusCode == 200) {
              setState(() {
                i = 1;
                showAlertDialog5(context);
              });
            } else {
              setState(() {
                i = 0;
              });
            }
          },
          child: Char_card(name: 'Update Information', cc: Colors.blueAccent),
        ),
        i == 1 ? Text("sucessfully add animal") : Container(),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  int tap = 0;
  File _selectedFile;
  getImage5(ImageSource source) async {
    tap = 1;
    final picker = ImagePicker();
    PickedFile image = await picker.getImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Crop Your Image",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile5 = cropped;
        path5 = _selectedFile5.path;
        showAlertDialog5(context);
      });
    }
  }

  getImage3(ImageSource source) async {
    final picker = ImagePicker();
    PickedFile image = await picker.getImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Crop Your Image",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile3 = cropped;
        path3 = _selectedFile3.path;
        showAlertDialog3(context);
      });
    }
  }

  String path5;
  String path3;
  Widget getImageWidget5() {
    if (_selectedFile5 != null) {
      return Image.file(
        _selectedFile5,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "Assets/photo6154508545861724877.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  File _selectedFile5;
  File _selectedFile3;
  Widget getImageWidget3() {
    if (_selectedFile3 != null) {
      return Image.file(
        _selectedFile3,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "Assets/photo6154508545861724877.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  String hTitle;
  String hCost;
  String hContent;
  Color selectedColor2 = Colors.black;
  bool isSwitch = true;
//initalize value

  String activeButton;
  TabController _tabController;
  AdTab _adTab;
  //AdTab2 _adTab2;
  _getdata() async {
    Dio dio = Dio();
//default is
    Response r = await dio.get(
        "https://channab.com/api/view_particular_element/?product_id=$id",
        options: Options(headers: {"token": widget.token}));
    print(r.data);
    setState(() {
      _adTab = adTabFromJson(r.data);
      // _adTab2 = adTab2FromJson(r.data);
    });
  }

  showAlertDialog3(BuildContext context) {
    // set up the list options

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Take or Choose Photo'),
      children: <Widget>[
        getImageWidget3(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
                color: Colors.green,
                child: Text(
                  "Camera",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  getImage3(ImageSource.camera);
                }),
            MaterialButton(
                color: Colors.deepOrange,
                child: Text(
                  "Gallery",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  getImage3(ImageSource.gallery);
                }),
          ],
        ),
        GestureDetector(
          onTap: () async {
            Map<String, String> body = {"animal_particular_id": id};
            final mineData =
                lookupMimeType(path3, headerBytes: [0xFF, 0xD8]).split("/");
            var image = await http.MultipartFile.fromPath("main_image", path3,
                contentType: MediaType(mineData[0], mineData[1]));
            SharedPreferences pref = await SharedPreferences.getInstance();
            String url = "https://channab.com/api/gallery_popup/";
            Map<String, String> headers = <String, String>{
              'token': widget.token
            };
            Map<String, String> requestBody = body;
            var uri = Uri.parse(url);
            var request = http.MultipartRequest('POST', uri)
              ..headers.addAll(headers)
              ..files.add(image)
              ..fields.addAll(requestBody);

            var res = await request.send();
            http.Response response = await http.Response.fromStream(res);
            var data = json.decode(response.body);
            print(data);
            if (response.statusCode == 200) {
              setState(() {
                //i = 1;
              });
            } else {
              setState(() {
                // i = 0;
              });
            }
          },
          child: Char_card(name: 'Save Information', cc: Colors.blueAccent),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  showAlertDialog0(BuildContext context) {
    // set up the list options
    int i = 0;
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Add Health'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Health Title   *required'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              hTitle = value;
            },
            decoration: InputDecoration(
              hintText: 'Health Title   *required',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Health Cost   *required'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              hCost = value;
            },
            decoration: InputDecoration(
              hintText: 'Health Coste   *required',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Add Content'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              hContent = value;
            },
            decoration: InputDecoration(
              hintText: 'Add Content',
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            Map<String, String> body = {
              "animal_particular_id": id,
              "title_health": hTitle,
              "cost": hCost,
              "description": hContent
            };

            SharedPreferences pref = await SharedPreferences.getInstance();
            String url = "https://channab.com/api/health_popup/";
            Map<String, String> headers = <String, String>{
              'token': widget.token
            };
            Map<String, String> requestBody = body;
            var uri = Uri.parse(url);
            var request = http.MultipartRequest('POST', uri)
              ..headers.addAll(headers)
              ..fields.addAll(requestBody);

            var res = await request.send();
            http.Response response = await http.Response.fromStream(res);
            var data = json.decode(response.body);
            print(data);
            if (response.statusCode == 200) {
              setState(() {
                i = 1;
              });
            } else {
              setState(() {
                i = 0;
              });
            }
          },
          child: Char_card(name: 'Save Information', cc: Colors.blueAccent),
        ),
        i == 1 ? Text("sucessfully save information") : Container(),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  showAlertDialog1(BuildContext context) {
    // set up the list options
    int i = 0;
    List _selecteCategorys = List();
    String currentCat;
    String currentCatF;
    String c;
    List<String> count = [];
    List<String> gg = [];
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Add Family'),
      children: <Widget>[
        Column(
          children: <Widget>[
            TextResponsive(
              'Male Parent',
              style: TextStyle(
                fontSize: 120.h,
              ),
            ),
            Container(
              child: DropdownButton<dynamic>(
                  underline: Container(),
                  hint: Text("Male Parent"),
                  value: currentCat,
                  items: _adTab.allMaleUserCanSelect
                      .map((e) => DropdownMenuItem<dynamic>(
                            child: Text(e["animal_tag"].toString()),
                            value: e,
                            onTap: () {},
                          ))
                      .toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      print(value);
                      currentCat = value.toString();
                      showAlertDialog1(context);
                      print(currentCat);
                    });
                  }),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            TextResponsive(
              'Female Parent',
              style: TextStyle(
                fontSize: 120.h,
              ),
            ),
            Container(
              width: 700,
              child: DropdownButton<dynamic>(
                  underline: Container(),
                  hint: Text("Female Parent"),
                  value: currentCatF,
                  items: _adTab.allFemaleUserCanSelect
                      .map((e) => DropdownMenuItem<dynamic>(
                            child: Text(e["animal_tag"].toString()),
                            value: e,
                            onTap: () {},
                          ))
                      .toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      print(value);
                      currentCatF = value.toString();
                      showAlertDialog1(context);
                      print(currentCatF);
                    });
                  }),
            ),
          ],
        ),
        Container(
          width: 700,
          child: DropdownButton<dynamic>(
              underline: Container(),
              hint: Text("Child"),
              value: currentCatF,
              items: _adTab.allChildsUserCanSelect
                  .map((e) => DropdownMenuItem<dynamic>(
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              onChanged: (value) {
                                count.add(_adTab.allChildsUserCanSelect
                                    .map(e["id"])
                                    .toString());
                              },
                              value: false,
                            ),
                            Text(e["animal_tag"].toString()),
                          ],
                        ),
                        value: e,
                        onTap: () {},
                      ))
                  .toList(),
              onChanged: (dynamic value) {}),
        ),
        GestureDetector(
          onTap: () async {
            String s = count.join(', ');
            Map<String, String> body = {
              "family_particular_id": id,
              "male_parent": currentCat,
              "female_parent": currentCatF,
              "child_select": s
            };

            //SharedPreferences pref = await SharedPreferences.getInstance();
            String url = "https://channab.com/api/add_child_api/";
            Map<String, String> headers = <String, String>{
              'token': widget.token
            };
            Map<String, String> requestBody = body;
            var uri = Uri.parse(url);
            var request = http.MultipartRequest('POST', uri)
              ..headers.addAll(headers)
              ..fields.addAll(requestBody);

            var res = await request.send();
            http.Response response = await http.Response.fromStream(res);
            var data = json.decode(response.body);
            print(data);
            if (response.statusCode == 200) {
              setState(() {
                // i = 1;
                //Navigator.pop(context);
              });
            } else {
              setState(() {
                // i = 0;
              });
            }
          },
          child: Char_card(name: 'Save Information', cc: Colors.blueAccent),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add_animal()),
            );
          },
          child: Char_card(name: 'Add Animal', cc: Colors.blueAccent),
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    // set up the list options
    String mmilk;
    String emilk;
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Add Milk'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Morning Milk   *required'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              mmilk = value;
            },
            decoration: InputDecoration(
              hintText: 'Morning Milk   *required',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Evening Milk   *required'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              emilk = value;
            },
            decoration: InputDecoration(
              hintText: 'Evening Milk',
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            Map<String, String> body = {
              "animal_particular_id": id,
              "morning_time": mmilk,
              "evening_time": emilk
            };

            SharedPreferences pref = await SharedPreferences.getInstance();
            String url = "https://channab.com/api/milking_popup/";
            Map<String, String> headers = <String, String>{
              'token': widget.token
            };
            Map<String, String> requestBody = body;
            var uri = Uri.parse(url);
            var request = http.MultipartRequest('POST', uri)
              ..headers.addAll(headers)
              ..fields.addAll(requestBody);

            var res = await request.send();
            http.Response response = await http.Response.fromStream(res);
            var data = json.decode(response.body);
            print(data);
            if (response.statusCode == 200) {
              setState(() {
                // i = 1;
                //Navigator.pop(context);
              });
            } else {
              setState(() {
                // i = 0;
              });
            }
          },
          child: Char_card(name: 'Save Information', cc: Colors.blueAccent),
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

//_animalId.currentAnimalBasicDetail.animalTag="";
  ActiveStatus _activeStatus;
  @override
  void initState() {
    super.initState();
    _getdata();
    getStatus();
    _tabController = new TabController(length: 5, vsync: this);
  }

  getStatus() async {
    Dio dio = Dio();
    Response r = await dio.get(
        "https://channab.com/api/deactivate_animal/?id=$id",
        options: Options(headers: {"token": widget.token}));
    // print(r.data);
    setState(() {
      _activeStatus = activeStatusFromJson(r.data);
      _activeStatus.msg == 'Active status' ? isSwitch = true : isSwitch = false;
    });
  }

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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,

          //backgroundColor: Colors.white60,
          body: _adTab == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 1000.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      _adTab.productDetails.productImage),
                                  radius: 50,
                                ),
                              ),
                              TextResponsive(
                                _adTab.productDetails.animalTag,
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: 150,
                            width: 680.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Color(0xff00B22D),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: TextResponsive(
                                          'Age ${_adTab.productDetails.ageInMonth} Month'
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Color(0xff00B22D),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: TextResponsive(
                                          _adTab.productDetails.animalGender,
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Color(0xff00B22D),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: TextResponsive(
                                          _adTab.productDetails.animalType,
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Color(0xff00B22D),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: TextResponsive(
                                          isSwitch == true
                                              ? 'Active'
                                              : 'Disabled',
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (_tabController.index == 0) {
                              showAlertDialog0(context);
                            } else if (_tabController.index == 1) {
                              showAlertDialog1(context);
                            } else if (_tabController.index == 2) {
                              showAlertDialog2(context);
                            } else if (_tabController.index == 3) {
                              showAlertDialog3(context);
                            } else if (_tabController.index == 4) {
                              showAlertDialog4(context);
                            }
                          },
                          child: CircleAvatar(
                              backgroundColor: Color(0xff00B22D),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                showAlertDialog5(context);
                              },
                              child: CircleAvatar(
                                  backgroundColor: Color(0xff00B22D),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Color(0xff00B22D),
                            child: Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Switch(
                          activeTrackColor: Color(0xff00B22D),
                          activeColor: Colors.white,
                          value: isSwitch,
                          onChanged: (value) {
                            setState(() {
                              isSwitch = value;
                            });
                          },
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    DefaultTabController(
                      initialIndex: 0,
                      // The number of tabs / content sections to display.
                      length: 5,
                      child: Center(
                        child: TabBar(
                          labelColor: Colors.white,
                          isScrollable: true,
                          indicator: BoxDecoration(
                            color: Color(0xff00B22D),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          unselectedLabelColor: selectedColor2,
                          controller: _tabController,
                          tabs: [
                            Tab(
                              child: Center(
                                child: TextResponsive(
                                  'Health',
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Center(
                                child: TextResponsive(
                                  'Family',
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Center(
                                child: TextResponsive(
                                  'Milking',
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Center(
                                child: TextResponsive(
                                  'Gallery',
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Center(
                                child: TextResponsive(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ), // Complete this code in the next step.
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 3000000.h,
                            width: 1000.w,
                            child: TabBarView(
                              children: [
                                Column(
                                  children: <Widget>[
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount:
                                            _adTab.allHealthRecordList.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          AllHealthRecordList item =
                                              _adTab.allHealthRecordList[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Text(item.tagName),
                                                      Text(
                                                          'Cost : ${item.costAmount.toString()} PKR'),
                                                      Text(item.ago),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          Dio dio = Dio();
                                                          DelHealth del_health;
                                                          Response r = await dio.get(
                                                              "https://channab.com/api/health_delete/?title_id=${item.id}",
                                                              options: Options(
                                                                  headers: {
                                                                    "token":
                                                                        widget
                                                                            .token
                                                                  }));
                                                          print(r.data);
                                                          setState(() {
                                                            del_health =
                                                                delHealthFromJson(
                                                                    r.data);
                                                          });
                                                          if (del_health
                                                                  .status ==
                                                              200) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Animal_details(
                                                                            token:
                                                                                widget.token,
                                                                          )),
                                                            );
                                                          }
                                                        },
                                                        child:
                                                            Icon(Icons.delete),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextResponsive(
                                                      item.textDescription,
                                                      style: TextStyle(
                                                          fontSize: 40),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                                Text("data2"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                                height: 60,
                                                width: 150.w,
                                                child: Center(
                                                  child: TextResponsive(
                                                    "DATE",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                )),
                                            Container(
                                                height: 60,
                                                width: 150.w,
                                                child: Center(
                                                    child: TextResponsive(
                                                  "MORNING",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ))),
                                            Container(
                                                height: 60,
                                                width: 150.w,
                                                child: Center(
                                                    child: TextResponsive(
                                                  "EVENING",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ))),
                                            Container(
                                                height: 60,
                                                width: 150.w,
                                                child: Center(
                                                    child: TextResponsive(
                                                  "TOTAL",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ))),
                                            Container(
                                                height: 60,
                                                width: 150.w,
                                                child: Center(
                                                    child: TextResponsive(
                                                  "ACTIONS",
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                  maxLines: 1,
                                                ))),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: _adTab.milkAllRecord
                                              .milkDataByRow.length,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return Container(
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Container(
                                                      height: 60,
                                                      width: 150.w,
                                                      child: Center(
                                                          child: TextResponsive(
                                                        _adTab
                                                            .milkAllRecord
                                                            .milkDataByRow[
                                                                index]
                                                            .createdOn,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                        ),
                                                      ))),
                                                  Container(
                                                      height: 60,
                                                      width: 150.w,
                                                      child: Center(
                                                          child: TextResponsive(
                                                        _adTab
                                                            .milkAllRecord
                                                            .milkDataByRow[
                                                                index]
                                                            .morningTime
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                        ),
                                                      ))),
                                                  Container(
                                                      height: 60,
                                                      width: 150.w,
                                                      child: Center(
                                                          child: TextResponsive(
                                                        _adTab
                                                            .milkAllRecord
                                                            .milkDataByRow[
                                                                index]
                                                            .eveningTime
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                        ),
                                                      ))),
                                                  Container(
                                                      height: 60,
                                                      width: 150.w,
                                                      child: Center(
                                                          child: TextResponsive(
                                                        _adTab
                                                            .milkAllRecord
                                                            .milkDataByRow[
                                                                index]
                                                            .sumOfOne
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                        ),
                                                      ))),
                                                  Container(
                                                    height: 60,
                                                    width: 150.w,
                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          Dio dio = Dio();
                                                          DelHealth del_health;
                                                          Response r = await dio.get(
                                                              "https://channab.com/api/milk_delete/?milk_id=${_adTab.milkAllRecord.milkDataByRow[index].id}",
                                                              options: Options(
                                                                  headers: {
                                                                    "token":
                                                                        widget
                                                                            .token
                                                                  }));
                                                          print(r.data);
                                                          setState(() {
                                                            del_health =
                                                                delHealthFromJson(
                                                                    r.data);
                                                          });
                                                          if (del_health
                                                                  .status ==
                                                              200) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Animal_details(
                                                                            token:
                                                                                widget.token,
                                                                          )),
                                                            );
                                                          }
                                                        },
                                                        child:
                                                            Icon(Icons.delete),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                      Container(
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Container(
                                              height: 60,
                                              width: 150.w,
                                              child: Center(
                                                child: TextResponsive(
                                                  'Total',
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 60,
                                              width: 150.w,
                                              child: Center(
                                                child: TextResponsive(
                                                  _adTab.milkAllRecord
                                                      .sumOfMorningColoumn
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 60,
                                              width: 150.w,
                                              child: Center(
                                                child: TextResponsive(
                                                  _adTab.milkAllRecord
                                                      .sumOfEveningColourmn
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 60,
                                              width: 150.w,
                                              child: Center(
                                                child: TextResponsive(
                                                  _adTab.milkAllRecord.sumOfAll
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 60,
                                              width: 150.w,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _adTab.gallerList.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return Padding(
                                        padding: EdgeInsets.all(30.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Stack(
                                            children: <Widget>[
                                              Image.network(_adTab
                                                  .gallerList[index].image),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    Dio dio = Dio();
                                                    DelHealth del_health;
                                                    Response r = await dio.get(
                                                        "https://channab.com/api/image_delete/?image_id=${_adTab.gallerList[index].id}",
                                                        options:
                                                            Options(headers: {
                                                          "token": widget.token
                                                        }));
                                                    print(r.data);
                                                    setState(() {
                                                      del_health =
                                                          delHealthFromJson(
                                                              r.data);
                                                    });
                                                    if (del_health.status ==
                                                        200) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Animal_details(
                                                                  token: widget
                                                                      .token,
                                                                )),
                                                      );
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child:
                                                          Icon(Icons.delete)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _adTab.allDescriptionList.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 200,
                                          color: Colors.white,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Text(_adTab
                                                      .allDescriptionList[index]
                                                      .createdOn),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      Dio dio = Dio();
                                                      DelHealth del_health;
                                                      Response r = await dio.get(
                                                          "https://channab.com/api/description_delete/?delete_desc_id=${_adTab.allDescriptionList[index].id}",
                                                          options: Options(
                                                              headers: {
                                                                "token":
                                                                    widget.token
                                                              }));
                                                      print(r.data);
                                                      setState(() {
                                                        del_health =
                                                            delHealthFromJson(
                                                                r.data);
                                                      });
                                                      if (del_health.status ==
                                                          200) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Animal_details(
                                                                    token: widget
                                                                        .token,
                                                                  )),
                                                        );
                                                      }
                                                    },
                                                    child: Icon(Icons.delete),
                                                  )
                                                ],
                                              ),
                                              Flexible(
                                                child: Text(
                                                  _adTab
                                                      .allDescriptionList[index]
                                                      .description,
                                                  style:
                                                      TextStyle(fontSize: 35),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                              controller: _tabController,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          //   bottomNavigationBar: BottomNavigationBar(
          //     // type: BottomNavigationBarType.fixed,
          //     selectedIconTheme: IconThemeData(color: Colors.green),
          //     selectedItemColor: Colors.green,
          //     unselectedItemColor: Color(0xff707070),
          //     showSelectedLabels: false,
          //     currentIndex: _selectedIndex,
          //     onTap: _onItemTapped,
          //     items: const <BottomNavigationBarItem>[
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.home,
          //         ),
          //         title: TextResponsive(
          //           'Home',
          //           style: optionStyle,
          //         ),
          //       ),
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.tram,
          //         ),
          //         title: TextResponsive(
          //           'My Farm',
          //           style: optionStyle,
          //         ),
          //       ),
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.people_outline,
          //         ),
          //         title: TextResponsive(
          //           'Users',
          //           style: optionStyle,
          //           textAlign: TextAlign.left,
          //         ),
          //       ),
          //       BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.settings,
          //         ),
          //         title: TextResponsive(
          //           'Settings',
          //           style: optionStyle,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
