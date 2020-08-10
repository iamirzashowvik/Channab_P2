import 'dart:convert';

import 'package:channab2day/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
//import 'filterScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'anilistest.dart';

class Animal_list extends StatefulWidget {
  @override
  _Animal_listState createState() => _Animal_listState();
}

class _Animal_listState extends State<Animal_list>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  bool selected = false;
  TabController _tabController;
  bool toggle = false;
  Color selectedColor1 = Colors.green;
  Color selectedColor2 = Colors.black;
  Color cc = Color(0xffff718b);
  Map<String, double> dataMap = Map();
  bool swvalue = false;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 35,
    //  color: const Color(0x4d130f10),
  );
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
    _tabController = new TabController(length: 3, vsync: this);
  }

  AnimallistModel animallistModel;
  getdata() async {
    Dio dio = Dio();

    Response r = await dio.get("https://channab.com/api/livestock_listing/",
        options: Options(
            headers: {"token": "50a67c112aff02f32cfefd52c242933b727d28bd"}));
    print(r.data);
    setState(() {
      animallistModel = animallistModelFromJson(r.data);
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
      child: Scaffold(
        body: animallistModel == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                // shrinkWrap: true,
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: TextResponsive(
                                'MyFarm',
                                style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => SingleChildScrollView(
                                            child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: FilterScreen(),
                                        )));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TextResponsive(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        DefaultTabController(
                          initialIndex: 0,
                          // The number of tabs / content sections to display.
                          length: 3,
                          child: TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: selectedColor2,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Center(
                                  child: TextResponsive(
                                    'Animal',
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Center(
                                  child: TextResponsive(
                                    'Milking',
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Center(
                                  child: TextResponsive(
                                    'Reports',
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ), // Complete this code in the next step.
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: animallistModel.allAnimalList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          AllAnimalList items =
                              animallistModel.allAnimalList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: TextResponsive(
                                items.animalType.toString().substring(11),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              )),
                            ),
                          );
                        }),
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
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      animallistModel.allAnimalList.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    AllAnimalList items =
                                        animallistModel.allAnimalList[index];
                                    return Animal_list_card(
                                      a_tag: items.animalTag,
                                      id: items.id,
                                      asset: items.image,
                                      gender: items.gender,
                                    );
                                  }),
                              Text("data2"),
                              Text("data3")
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
        bottomNavigationBar: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Colors.green),
          selectedItemColor: Colors.green,
          unselectedItemColor: Color(0xff707070),
          showSelectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: TextResponsive(
                'Home',
                style: optionStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.tram,
              ),
              title: TextResponsive(
                'My Farm',
                style: optionStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people_outline,
              ),
              title: TextResponsive(
                'Users',
                style: optionStyle,
                textAlign: TextAlign.left,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              title: TextResponsive(
                'Settings',
                style: optionStyle,
              ),
            ),
          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                  child: TextResponsive(
                'Add   Animal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class Animal_list_card extends StatelessWidget {
  final String asset;
  final String a_tag;
  final int id;
  final Gender gender;
  Animal_list_card({this.a_tag, this.asset, this.id, this.gender});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(asset),
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextResponsive(
                          a_tag,
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                        TextResponsive(
                          id.toString(),
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: TextResponsive(
                          gender.toString().substring(7),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        )),
                      ),
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
