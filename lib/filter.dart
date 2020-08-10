import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
                  'Age',
                  style: TextStyle(fontSize: 100.h),
                ),
              ),
              Container(
                height: 150.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Diet_card(name: 'Less than 5 months', color: dc),
                    Diet_card(name: 'Less than 6 months', color: dc),
                    Diet_card(name: 'Less than 10 months', color: dc),
                    Diet_card(name: 'Less than 12 months', color: dc),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Type',
                  style: TextStyle(fontSize: 100.h),
                ),
              ),
              Container(
                height: 150.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Diet_card(name: 'Cow', color: dc),
                    Diet_card(name: 'Horse', color: dc),
                    Diet_card(name: 'Dubai', color: dc),
                    Diet_card(name: 'Berlin', color: dc),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextResponsive(
                  'Sex',
                  style: TextStyle(fontSize: 100.h),
                ),
              ),
              Container(
                height: 150.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Diet_card(name: 'Male', color: dc),
                    Diet_card(name: 'Female', color: dc),
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
                    Diet_card(name: 'Normal', color: dc),
                    Diet_card(name: 'Pragnant', color: dc),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Diet_card extends StatefulWidget {
  Diet_card({
    @required this.name,
    @required this.color,
  });
  final String name;
  final Color color;

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
                fontFamily: 'SofiaPro',
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
