import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:try_app/screens/forms.dart';
import 'package:try_app/utils.dart/circular_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FixedExtentScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> li = [
      "Android Development",
      "Data Science",
      "Full Stack Develoment",
      "Internet of Things",
      "Software Development",
      "UI/UX",
      "Web Development"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Intenships',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onPressed: () {
          final currindex = controller.selectedItem;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Forms(
                    head: li[currindex],
                  )));
        },
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 85),
          child: ListWheelScrollView(
            controller: controller,
            itemExtent: 200,
            physics: FixedExtentScrollPhysics(),
            perspective: 0.009,
            diameterRatio: 4,
            useMagnifier: true,
            magnification: 1.1,
            offAxisFraction: -1.5,
            onSelectedItemChanged: (index) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.lightBlue,
                    duration: Duration(milliseconds: 1000),
                    content: Text(
                      li[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
            },
            children: <Widget>[
              CircularAva(img: 'assets/android.png'),
              CircularAva(img: 'assets/datasci.png'),
              CircularAva(img: 'assets/fullstack.png'),
              CircularAva(img: 'assets/iot.png'),
              CircularAva(img: 'assets/software.png'),
              CircularAva(img: 'assets/uiux.png'),
              CircularAva(img: 'assets/webd.png'),
            ],
          ),
        ),
      ),
    );
  }
}
