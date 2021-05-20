import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Row(children: [
            Image.asset("assets/images/dlogo.png",height: 200,width: 200,),
            Text("Admin"),
          ],),
          Row(children: [
            Expanded(
                child: ElevatedButton(
                  child: Text(
                    "ADD Questions",
                    style: TextStyle(fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(color: Colors.pink),
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                  ),
                  onPressed: () async {

                  },
                )),
          ],)
          
        ],),


      ),
    );
  }
}
