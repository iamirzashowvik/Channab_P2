import 'dart:async';
import 'dart:convert';
import 'package:android_intent/android_intent.dart';
import 'package:geolocator/geolocator.dart';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User_Profile extends StatefulWidget {
  final String token;
  User_Profile({this.token});
  @override
  _User_ProfileState createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  TextEditingController _tagController = TextEditingController();
  File _selectedFile;

  String fullName;
  String gender;
  String email;
  String name = "Username/Mobile Number";
  String currentCat;
  String assetname;
  Widget getImageWidget() {
    if (_selectedFile != null) {
      return CircleAvatar(
        radius: 63,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(assetname),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          showAlertDialog1(context);
        },
        child: CircleAvatar(
          radius: 63,
          backgroundColor: Colors.blue,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: Icon(Icons.add_a_photo),
          ),
        ),
      );
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.blue, width: 2),
    );
  }

  int i = 0;
  getImage(ImageSource source) async {
    this.setState(() {});
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
        assetname = _selectedFile.path;
      });
    } else {
      this.setState(() {});
    }
  }

  showAlertDialog1(BuildContext context) {
    // set up the list options

    Widget optionOne = SimpleDialogOption(
      child: const Text('Camera'),
      onPressed: () {
        getImage(ImageSource.camera);
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: const Text('Gallery'),
      onPressed: () {
        getImage(ImageSource.gallery);
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text('Take or Choose Photo'),
      children: <Widget>[
        optionOne,
        optionTwo,
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

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get gurrent location"),
              content:
                  const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  String _address = "";
  var position;
  void _getCurrentLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    print('ggg   g  $position');
    // create this variable

    List<Placemark> newPlace = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address =
        "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(address);

    setState(() {
      _address = address; // update _address
    });
  }

  @override
  void initState() {
    super.initState();
    _checkGps();
    _getCurrentLocation();
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
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: TextResponsive(
            'Personal Information',
            style: TextStyle(
              fontSize: 50,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ],
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
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topCenter,
                            child: getImageWidget()),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              showAlertDialog1(context);
                            },
                            child: CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // (_inProcess)
                    //     ? Container(
                    //         color: Colors.white,
                    //         child: Center(
                    //           child: CircularProgressIndicator(),
                    //         ),
                    //       )
                    //     : Center()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextResponsive(
                    name,
                    style: TextStyle(
                      fontSize: 120.h,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: myBoxDecoration(),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Username/Mobile Number',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                          print(name);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: myBoxDecoration(),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          fullName = value;
                          print(name);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: myBoxDecoration(),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                          print(name);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    height: 300,
                    decoration: myBoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Map<String, String> body = {
                      "full_name": name,
                      "email": email,
                      "address": _address,
                    };
                    final mineData = lookupMimeType(_selectedFile.path,
                        headerBytes: [0xFF, 0xD8]).split("/");
                    var image = await http.MultipartFile.fromPath(
                        "main_image", _selectedFile.path,
                        contentType: MediaType(mineData[0], mineData[1]));
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    String url = "https://channab.com/" + "api/edit_profile/";
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
                      setState(() {
                        i = 1;
                      });
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "SAVE",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                i == 1 ? Text("sucess") : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
