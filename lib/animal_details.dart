import 'dart:io';
import 'dart:convert';
import 'package:channab2day/model/activeS_AD.dart';
import 'package:channab2day/model/char_card.dart';
import 'package:http/http.dart' as http;
import 'package:channab2day/add_animal.dart';
import 'package:channab2day/model/animal_id.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class Animal_details extends StatefulWidget {
  @override
  _Animal_detailsState createState() => _Animal_detailsState();
}

class _Animal_detailsState extends State<Animal_details>
    with SingleTickerProviderStateMixin {
  String token = "50a67c112aff02f32cfefd52c242933b727d28bd";
  String id = "19";
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
            Map<String, String> headers = <String, String>{'token': token};
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

  showAlertDialog5(BuildContext context) {
    // set up the list options
    int i = 0;

    String kIanimaltag;
    String kIcoP;
    String kIage;
    String kIgender;
    String kIcurentType;
    String kIbreed;
    String kIdop;
    // set up the SimpleDialog
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
            onChanged: (value) {
              kIcoP = value;
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
                      print(kIdop);
                    });
                  });
                }),
          ),
        ),
        getImageWidget(),
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
                    getImage(ImageSource.camera);
                  }),
              MaterialButton(
                  color: Colors.deepOrange,
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  }),
            ]),
        GestureDetector(
          onTap: () async {
            Map<String, String> body = {
              "animal_tag": kIanimaltag,
              "animal_particular_id": "42", //this need to dynamic
              "age": kIage,
              "animal_bread": kIbreed,
              "gender": kIgender,
              // "animal_type": kI,
              "cost_purchase": kIcoP,
              "date_of_purchase": kIdop,
            };
            final mineData =
                lookupMimeType(_selectedFile.path, headerBytes: [0xFF, 0xD8])
                    .split("/");
            var image = await http.MultipartFile.fromPath(
                "main_image", _selectedFile.path,
                contentType: MediaType(mineData[0], mineData[1]));
            SharedPreferences pref = await SharedPreferences.getInstance();
            String url = "https://channab.com/api/main_animal_info_update/";
            Map<String, String> headers = <String, String>{'token': token};
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
                i = 1;
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

  File _selectedFile;
  getImage(ImageSource source) async {
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
        _selectedFile = cropped;
        // showAlertDialog5(context);
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

  String path3;
  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
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
  bool isSwitch;

  String activeButton;
  TabController _tabController;
  AnimalId _animalId;
  _getdata() async {
    Dio dio = Dio();
//default is
    Response r = await dio.get(
        "https://channab.com/api/view_particular_element/?product_id=$id",
        options: Options(
            headers: {"token": "50a67c112aff02f32cfefd52c242933b727d28bd"}));
    print(r.data);
    setState(() {
      _animalId = animalIdFromJson(r.data);
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
            Map<String, String> headers = <String, String>{'token': token};
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
            Map<String, String> headers = <String, String>{'token': token};
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
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Add Family'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Male Parent'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              hTitle = value;
            },
            decoration: InputDecoration(
              hintText: 'Male Parent',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Female Parent'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              hCost = value;
            },
            decoration: InputDecoration(
              hintText: 'Female Parent',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Select Child'),
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
          onTap: () async {},
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
            Map<String, String> headers = <String, String>{'token': token};
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
        options: Options(
            headers: {"token": "50a67c112aff02f32cfefd52c242933b727d28bd"}));
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
          backgroundColor: Colors.white60,
          body: _animalId == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 175,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(_animalId
                                        .currentAnimalBasicDetail.productImage),
                                    radius: 50,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(
                                      //  mainAxisAlignment: MainAxisAlignment.,
                                      children: <Widget>[
                                        Char_card(
                                          name:
                                              'Age ${_animalId.currentAnimalBasicDetail.ageInMonth.toString()} Month',
                                          cc: Colors.green,
                                        ),
                                        Char_card(
                                          name: _animalId
                                              .currentAnimalBasicDetail
                                              .animalGender,
                                          cc: Colors.green,
                                        ),
                                        Char_card(
                                          name: _animalId
                                              .currentAnimalBasicDetail
                                              .animalType,
                                          cc: Colors.green,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Char_card(
                                          name: _animalId
                                              .currentAnimalBasicDetail
                                              .animalBreed,
                                          cc: Colors.green,
                                        ),
                                        Char_card(
                                          name:
                                              isSwitch ? 'Active' : 'Disabled',
                                          cc: isSwitch
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        Switch(
                                          value: isSwitch,
                                          onChanged: (value) {
                                            setState(() {
                                              isSwitch = value;
                                            });
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Char_card(
                                  name: _animalId
                                      .currentAnimalBasicDetail.animalTag,
                                  cc: Colors.green,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.notifications_active,
                                    color: Colors.white,
                                  ),
                                ),
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
                                      } else {
                                        showAlertDialog4(context);
                                      }
                                    },
                                    child: Icon(Icons.add)),
                                GestureDetector(
                                    onTap: () {
                                      showAlertDialog5(context);
                                    },
                                    child: Icon(Icons.edit)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 80,
                        child: DefaultTabController(
                          initialIndex: 0,
                          // The number of tabs / content sections to display.
                          length: 5,
                          child: TabBar(
                            labelColor: Colors.blue,
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
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ), // Complete this code in the next step.
                        ),
                      ),
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
                                Text("data2"),
                                // ListView.builder(
                                //   physics: NeverScrollableScrollPhysics(),
                                //   scrollDirection: Axis.vertical,
                                //   shrinkWrap: true,
                                //   itemCount: 5,
                                // itemBuilder: (BuildContext ctxt, int index) {
                                //   AllAnimalList items =
                                //       animallistModel.allAnimalList[index];
                                // return Animal_list_card(
                                //   a_tag: items.animalTag,
                                //   id: items.id,
                                //   asset: items.image,
                                //   gender: items.gender,
                                // );}
                                //),
                                Text("data2"),
                                Text("data3"),
                                Text("data4"),
                                Text("data5"),
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
        ),
      ),
    );
  }
}
