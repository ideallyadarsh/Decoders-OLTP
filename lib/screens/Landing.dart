import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oltp/screens/TestRegistration.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  
  var submitButtonState=0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void setButtonState(int state){
    setState(() {
      submitButtonState = state;
    });
  }
  
  Future<bool> getTestsOnceOff(String testID) async {
    bool testExistFlag;
    try {
      await _testsCollectionReference.document(testID.toLowerCase()).get().then((querysnapshot) => {
        if(querysnapshot.exists)
          {
            testExistFlag=true,
          }
        else testExistFlag=false,
      });
//      await _testsCollectionReference.getDocuments().then((querySnapshot) => {
//        querySnapshot.documents.forEach((element) {
//          print(element.data);
//        })
//      });
    } catch (e) {
      setButtonState(0);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
    content: e.toString().contains("Invalid document")?Text("Test ID is Empty"):e.toString().contains("offline")?Text("Client is Offline. Check your connection."):Text("Failed to get document."),
    ));
      print("i-error:"+e.toString());
      return false;
    }
    return Future<bool>.value(testExistFlag);
  }

  final CollectionReference _testsCollectionReference = Firestore.instance.collection('tests');
  String TestID;
  bool validID;
  final testIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff36393f),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Center(child: Hero(tag:'logo',child: Image(image: AssetImage('assets/images/dlogo.png'),width: MediaQuery.of(context).size.width * 0.4,height: MediaQuery.of(context).size.height * 0.4,))),
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
              onTap: ()async=>{
                setButtonState(1),
                  TestID=testIDController.text,
    if(TestID.isEmpty)
      {
      setButtonState(0),
      _scaffoldKey.currentState.showSnackBar(SnackBar(
      content:Text("Test ID is Empty"),
      ))
      }
      else{
    validID = await getTestsOnceOff(TestID),
    print(validID),
    if(validID)
    Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => TestRegistration(TestID)
    )
    )
    else
    {
    setButtonState(0),
    _scaffoldKey.currentState.showSnackBar(SnackBar(
    content:Text("Invalid Test ID"),
    )),
    }
    }
              },
              child: Container(
                  width : MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xff145cae),
                  ),
                  child: Center(
                    child: submitButtonState==0?Text("SUBMIT",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,):
        CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
    )
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
