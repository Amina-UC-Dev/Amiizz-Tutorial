import 'dart:convert';
import 'package:amiizz_tutorial1/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //email : ami@gmail.com
  // password: 123456

  @override
  void initState() {
    setState(() {
      showalert = false;
    });
    super.initState();
  }

  Future _signinApi(username, password) async {
    setState(() {
      showalert=true;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              contentPadding: EdgeInsets.all(0),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/loading.gif",
                          height: 90,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
    print("my username : " + username + " password : " + password);
    final String url =
        "http://sales.grandmasfoods.com/public/api/deliveryboylogin";
    final res = await http.post(url, body: {
      "email": username,
      "password": password,
    });
    var RegData = json.decode(res.body);
    print("Response : " + RegData.toString());
    setState(() {
      showalert= false;
    });
    Navigator.pop(context);
    if (RegData["status"] == "200") {
      Fluttertoast.showToast(
          msg: RegData["message"],
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: RegData["message"],
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }
  }

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool showalert;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Amiizz Tutorial"),
      ),
      body:/* showalert
          ? Center(
            child: Image.asset(
                "assets/loading.gif",
                height: 90,
                color: Colors.red,
              ),
          )
          : */Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/smiley.png",
                    height: 60,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Welcome"),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: _username,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _password,
                    obscureText: false,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    color: Colors.red,
                    onPressed: () {
                      _signinApi(_username.text, _password.text);
                    },
                    height: 40,
                    minWidth: w / 1.5,
                    child: Text("Login"),
                  )
                ],
              ),
            ),
    );
  }
}
