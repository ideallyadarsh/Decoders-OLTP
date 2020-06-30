import 'dart:convert';

import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final Base64Codec base64 = Base64Codec();
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

@override
  void initState() {
  var decoded = base64.decode("ID2ieOjCrwfgWvL5sXl4B1ImC5QfbsDy45VodOp69Ct+ELDPTIJAG0G0UKUFYwlBou\/XzOynB+dpZ6NgZ19OsBw7tS9a8Gtq");
  print(decoded);
    super.initState();
  }


  final testIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36393f),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Center(child: Image(image: AssetImage('assets/images/dlogo.png'),width: MediaQuery.of(context).size.width * 0.4,height: MediaQuery.of(context).size.height * 0.4,)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
            child: Container(
              child: TextField(
                controller: testIDController,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                  fillColor: Color(0xff36393f),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2f3136))
                  ),
                  prefixIcon: Icon(Icons.keyboard_hide,color: Colors.white70,),
                  labelText: "Input Test ID",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: Color(0xff2f3136),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: InkWell(
              child: Container(
                  width : MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xff145cae),
                  ),
                  child: Center(
                    child: Text("SUBMIT",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
