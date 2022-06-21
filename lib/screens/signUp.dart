import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:try_app/screens/home.dart';
import 'package:try_app/screens/login.dart';
import 'package:try_app/utils.dart/auth.dart';
import 'package:try_app/utils.dart/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool flag = false;

  void signUp() async {
    setState(() {
      flag = true;
    });

    String res = await AuthMethods().SignInUser(
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text);

    if (res == "Success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      SnackBar(
        content: Text("Check email or password"),
      );
    }

    setState(() {
      flag = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Container(
              child: Image.asset(
                'assets/expo.png',
              ),
            ),
            TextFieldInput(
              textInputType: TextInputType.emailAddress,
              hintText: 'Enter your name',
              textEditingController: _nameController,
              isPass: false,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textInputType: TextInputType.text,
              hintText: 'Enter your email',
              textEditingController: _emailController,
              isPass: false,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textInputType: TextInputType.text,
              hintText: 'Enter your password',
              textEditingController: _passwordController,
              isPass: true,
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: signUp,
              child: Container(
                child: !flag
                    ? Text(
                        'Sign Up',
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
            SizedBox(
              height: 24,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("Already have an account? "),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Log In.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
