import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oltp/screens/AdminPanel.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKeyLogin = new GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signInWithEmailAndPassword(String email,String pass) async {
    try {
      final user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      )).user;

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => AdminPanel()
      )
      );
    } catch (e) {
      print(e);
      _scaffoldKeyLogin.currentState.showSnackBar(SnackBar(
        content: Text("Failed to sign in"),
      ));
    }
  }

  final userTextController= new TextEditingController();
  final passTextController= new TextEditingController();

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyLogin,
      backgroundColor: Color(0xff36393f),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    child: Hero(tag:'logo',child: Image(image: AssetImage('assets/images/dlogo.png'),)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.07,
                      width: MediaQuery.of(context).size.width*0.25,
                      child: TextField(
                        controller: userTextController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                        decoration: InputDecoration(
                          fillColor: Color(0xff3639ff),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff2f3136))
                            ),
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.supervised_user_circle,
                            color: Colors.white54,
                          ),
                          hintText: 'User ID',
                          hintStyle: TextStyle(color: Colors.white54)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.07,
                      width: MediaQuery.of(context).size.width*0.25,
                      child: TextField(
                        controller: passTextController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                        decoration: InputDecoration(
                            fillColor: Color(0xff3639ff),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff2f3136))
                            ),
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.white54,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white54)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  InkWell(
                    onTap: (){
                        _signInWithEmailAndPassword(userTextController.text, passTextController.text);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      height: MediaQuery.of(context).size.height*0.07,
                      decoration: BoxDecoration(
                        color: Color(0xff145cae),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff145cae),
                            blurRadius: 3.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(child: Text("LOGIN",style: TextStyle(color: Colors.white70,fontSize:25,fontWeight: FontWeight.w500,letterSpacing: 1.5))),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
