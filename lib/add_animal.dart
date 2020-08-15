import 'dart:convert';
import 'package:channab2day/animal_list.dart';
import 'package:channab2day/model/animal_Categoru.dart';
import 'package:channab2day/model/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Add_animal extends StatefulWidget {
  final String token;
  Add_animal({this.token});
  @override
  _Add_animalState createState() => _Add_animalState();
}

class _Add_animalState extends State<Add_animal> {
  AnimalCategory animalCategory;
  getCategory() async {
    Dio dio = Dio();
    Response r = await dio.get("https://channab.com/api/all_category/",
        options: Options(headers: {"token": widget.token}));
    // print(r.data);
    setState(() {
      animalCategory = animalCategoryFromJson(r.data);
    });
  }

  TextEditingController _tagController = TextEditingController();
  File _selectedFile;
  List<Note> _notes = List<Note>();
  int i = 0;
  // Future<List<Note>> fetchNotes() async {
  //   var url = 'https://channab.com/api/all_category/';
  //   var response = await http.get(url);

  //   var notes = List<Note>();
  //   print('hi ${response}');
  //   if (response.statusCode == 200) {
  //     var notesJson = json.decode(response.body);
  //     for (var noteJson in notesJson) {
  //       notes.add(Note.fromJson(noteJson));
  //     }
  //   }
  //   return notes;
  // }
  File _file;
  bool _inProcess = false;
  String _date;
  String gender;
  String type = 'DRY';
  String name;
  String currentCat;
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

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
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
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  void initState() {
    getCategory();
    super.initState();
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
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: TextResponsive(
            'Add Animal',
            style: TextStyle(
              fontSize: 50,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 3000,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                                })
                          ],
                        )
                      ],
                    ),
                    (_inProcess)
                        ? Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Center()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextResponsive(
                          'Animal Tag/Name',
                          style: TextStyle(
                            fontSize: 120.h,
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
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Animal Tag/Name'),
                            onChanged: (value) {
                              setState(() {
                                name = value;
                                print(name);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: TextResponsive(
                      'Date of Birth',
                      style: TextStyle(
                        fontSize: 120.h,
                      ),
                    ),
                    title: _date == null ? Container() : Text(_date),
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
                              _date = date.toString().split(" ")[0];
                              print(_date);
                            });
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: TextResponsive(
                      'Category',
                      style: TextStyle(
                        fontSize: 120.h,
                      ),
                    ),
                    trailing: animalCategory == null
                        ? Center(child: CircularProgressIndicator())
                        : DropdownButton<String>(
                            underline: Container(),
                            hint: Text("Category"),
                            value: currentCat,
                            items: animalCategory.allCategories
                                .map((e) => DropdownMenuItem<String>(
                                      child: Text(e.nameOfCategory),
                                      value: e.nameOfCategory,
                                      onTap: () {
                                        //getParent(e.id);
                                      },
                                    ))
                                .toList(),
                            onChanged: (String value) {
                              setState(() {
                                print(value);
                                currentCat = value;
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
                        value: gender,
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
                            gender = value;
                            _file = File(_selectedFile.path);
                            print(_date);
                            print(currentCat);
                            print(gender);
                            print(_selectedFile.path);
                          });
                        }),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Map<String, String> body = {
                      "animal_tag": name,
                      "age": _date,
                      "category": currentCat,
                      "gender": gender,
                      "animal_type": type,
                    };
                    final mineData = lookupMimeType(_selectedFile.path,
                        headerBytes: [0xFF, 0xD8]).split("/");
                    var image = await http.MultipartFile.fromPath(
                        "main_image", _selectedFile.path,
                        contentType: MediaType(mineData[0], mineData[1]));
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    String url =
                        "https://channab.com/" + "api/live_animal_Add/";
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
                    http.Response response =
                        await http.Response.fromStream(res);
                    var data = json.decode(response.body);
                    print(data);
                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Animal_list(
                                  token: widget.token,
                                )),
                      );
                    } else {
                      setState(() {
                        i = 0;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 50),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                i == 1 ? Text("sucessfully add animal") : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
