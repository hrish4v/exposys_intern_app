import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:try_app/utils.dart/auth.dart';
import 'package:try_app/utils.dart/text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Forms extends StatefulWidget {
  final String head;
  const Forms({required this.head});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _10Controller = TextEditingController();
  final TextEditingController _12Controller = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool flag = false;
  String? _months = '1';
  List<String> monthslist = ['1', '2', '3', '4', '5', '6'];
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  void addIntern() async {
    String res = await AuthMethods().addData(
      internship: widget.head,
      name: _nameController.text,
      branch: _branchController.text,
      email: _emailController.text,
      collegeName: _collegeController.text,
      number: _phoneController.text,
      tenthPer: _10Controller.text,
      twelthPer: _12Controller.text,
      location: _locationController.text,
      months: _months!,
    );
    if (res == "You have already applied for this intership") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightBlue,
          duration: Duration(milliseconds: 1000),
          content: Text(
            "You have already applied for this intership",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      Navigator.of(context).pop();
    }
    if (res == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightBlue,
          //duration: Duration(milliseconds: 1000),
          content: Text(
            "You sucessfully applied for the intership",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightBlue,
          duration: Duration(milliseconds: 1000),
          content: Text(
            "Some problem occured...Try again",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.head,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: ListView(
          children: <Widget>[
            Flexible(
              child: Container(),
              flex: 2,
            ),
            TextFieldInput(
                textInputType: TextInputType.name,
                hintText: "Name",
                textEditingController: _nameController,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            TextFieldInput(
                textInputType: TextInputType.name,
                hintText: "Branch",
                textEditingController: _branchController,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            TextFieldInput(
                textInputType: TextInputType.emailAddress,
                hintText: "Email id",
                textEditingController: _emailController,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            TextFieldInput(
                textInputType: TextInputType.name,
                hintText: "College name",
                textEditingController: _collegeController,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            TextFieldInput(
                textInputType: TextInputType.number,
                hintText: "Contact number",
                textEditingController: _phoneController,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            TextFieldInput(
                textInputType: TextInputType.number,
                hintText: "10th Percentage",
                textEditingController: _10Controller,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            TextFieldInput(
                textInputType: TextInputType.number,
                hintText: "12th Percentage",
                textEditingController: _12Controller,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            TextFieldInput(
                textInputType: TextInputType.name,
                hintText: "Location",
                textEditingController: _locationController,
                isPass: false),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              child: DropDownFormField(
                titleText: 'Internship looking for(months)',
                value: _months,
                hintText: 'choose for 1 month',
                onChanged: (value) {
                  setState(() {
                    _months = value;
                  });
                },
                onSaved: (value) {
                  _months = value;
                },
                dataSource: [
                  {
                    "display": "1",
                    "value": "1",
                  },
                  {
                    "display": "2",
                    "value": "2",
                  },
                  {
                    "display": "3",
                    "value": "3",
                  },
                  {
                    "display": "4",
                    "value": "4",
                  },
                  {
                    "display": "5",
                    "value": "5",
                  },
                  {
                    "display": "6",
                    "value": "6",
                  }
                ],
                textField: 'display',
                valueField: 'value',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: addIntern,
              child: Container(
                child: !flag
                    ? Text(
                        'Apply now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )
                    : Center(
                        child: SpinKitFoldingCube(
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
