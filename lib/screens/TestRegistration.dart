import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oltp/models/QuestionModel.dart';
import 'package:oltp/models/StudentModel.dart';
import 'package:oltp/screens/Instructions.dart';

class TestRegistration extends StatefulWidget {
  final String TestID;

  TestRegistration(this.TestID);

  @override
  _TestRegistrationState createState() => _TestRegistrationState();
}

class _TestRegistrationState extends State<TestRegistration> {

  final studentOneNameController = TextEditingController();
  final studentOneUSNController = TextEditingController();
  final studentOnePhoneController = TextEditingController();
  final studentOneEmailController = TextEditingController();

  final studentTwoNameController = TextEditingController();
  final studentTwoUSNController = TextEditingController();
  final studentTwoPhoneController = TextEditingController();
  final studentTwoEmailController = TextEditingController();

  final teamNameController = TextEditingController();
  Student studentOne;
  Student studentTwo;

  var maxMembers=1;
  String testName;
  String testDescription;
  String testDate;
  String noOfQuestions;
  String maxQuestions;
  String testType;
  String testTime;
  String testInstructions;
  bool isactive=false;
  bool isover=false;

  List<Question> questions;

  var autoValidate = false;

  final _formKeyOne = GlobalKey<FormState>();
  final _formKeyTwo = GlobalKey<FormState>();

  String validateName(String value) {
    if(value.isEmpty)
      return "Name is Empty";
    else if (value.contains(new RegExp(r'^a-zA-Z'))) {
      return "Invalid Character(s)";
    }
    else 
    return null;
  }

  String validateMobile(String value) {
    if (value.length != 10)
      return 'Number must be of 10 digit';
    else if (value.contains(new RegExp(r'^0-9'))) {
      return "Invalid Character(s)";
    }
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateUSN(String value) {
    Pattern pattern =
        r'1[a-zA-Z][a-zA-Z][0-9][0-9][a-zA-Z][a-zA-Z][0-9][0-9][0-9]';
    RegExp regex = new RegExp(pattern);
    if (value.length != 10)
      return 'USN must be of 10 digit';
    else if (value.contains(new RegExp(r'^a-zA-Z0-9'))) {
      return "Invalid Character(s)";
    }
    else if(!regex.hasMatch(value))
      return 'Invalid USN';
    else
      return null;
  }

  void _setAutoValidate() {
      setState(() {
        autoValidate = true;
      });
  }

  saveStudentData(){
  studentOne = new Student(studentOneNameController.text, studentOneUSNController.text, studentOnePhoneController.text, studentOneEmailController.text);
  if(maxMembers==2)
    studentTwo = new Student(studentTwoNameController.text, studentTwoUSNController.text, studentTwoPhoneController.text, studentTwoEmailController.text);
  }

  getTestsOnceOff(String testID) async {

    var snapshotData;
    List<Question> ques = List<Question>.empty(growable: true);
    int i=0;
    var questionsCount;
    try {
      print("try block");
      await _testsCollectionReference.doc(testID).get().then((value) => {
        setState((){
          snapshotData = value.data();
        })

      });
  setState(() {
    print("setstate block");
    testDate=snapshotData["date"];
    testName=snapshotData["name"];
    testTime=snapshotData["time"];
    testType=snapshotData["type"];
    testInstructions=snapshotData["instruct"];
    testDescription=snapshotData["desc"];
    maxMembers=int.parse(snapshotData["maxmemb"]);
    noOfQuestions=snapshotData["noofquestion"].toString();
    maxQuestions=snapshotData["maxquestions"];
    isactive=snapshotData["activetest"];
    isover=snapshotData["isover"];
  });

  await _testsCollectionReference.doc(testID).collection("questions").get().then((value) {
    i=value.docs.length;
    for (var j = 0; j < i; j++)
     {
       ques.add(Question.fromJson(value.docs[j].data()));
       print(ques[j]);
     }
  });
  setState(() {
    questions = ques;
  });
    } catch (e) {
    print(e.toString());
    return;
    }
    return;
  }

  final CollectionReference _testsCollectionReference = FirebaseFirestore.instance.collection('tests');
  @override
  void initState() {
    print("gettestonece called");
    getTestsOnceOff(widget.TestID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36393f),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
        child: AppBar(
          backgroundColor: Color(0xff2f3136),
          automaticallyImplyLeading: false, // hides leading widget
          flexibleSpace: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.05,
              ),
              Container(
                  width:MediaQuery.of(context).size.width*0.1,child: Hero(tag:'logo',child: Image(image: AssetImage('assets/images/dlogo.png',),height: 120,))
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.025,
              ),
              Expanded(
                child: Container(
                  // width:MediaQuery.of(context).size.width*0.675,
                  // height: 100,
                  child: Text(testName==null?"":testName.toUpperCase(),style: TextStyle(color: Colors.white70,fontSize:50,fontWeight: FontWeight.bold,letterSpacing: 0.5)),
                ),
              )
            ],
          )
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Center(
            child: Container(
              width : MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff2f3136),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      width : MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xff145cae),
                      ),
                      child: Text("TEST INFO",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,)
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                //color: Colors.blue,
                                width : MediaQuery.of(context).size.width * 0.03,
                                height: MediaQuery.of(context).size.height*0.04,
                                child:  Icon(Icons.date_range,color: Colors.white70,),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.09,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Align(alignment:Alignment.centerLeft,child: Text("DATE :         ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),)),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Text(testDate==null?"":testDate,style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.004,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Icon(Icons.pie_chart_outlined,color: Colors.white70,),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Align(alignment:Alignment.centerLeft,child: Text("TEST TYPE :",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Text(testType==null?"":testType,style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.004,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Icon(Icons.people,color: Colors.white70,),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Align(alignment:Alignment.centerLeft,child: Text("MEMBERS : ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Text(maxMembers.toString()==null?"":maxMembers.toString(),style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                //color: Colors.blue,
                                width : MediaQuery.of(context).size.width * 0.03,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Icon(Icons.timer,color: Colors.white70,),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.09,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Align(alignment:Alignment.centerLeft,child: Text("DURATION :  ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),)),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: Text(testTime==null?"":(testTime+" minutes"),style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.004,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Icon(Icons.library_books,color: Colors.white70,),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Align(alignment:Alignment.centerLeft,child: Text("QUESTIONS :",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: Text(maxQuestions==null?"":maxQuestions,style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.004,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Icon(Icons.assessment,color: Colors.white70,)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Align(alignment:Alignment.centerLeft,child: Text("TEST ID :      ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),))),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Text(widget.TestID.toUpperCase(),style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  if(maxMembers==1)
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    height: MediaQuery.of(context).size.height*0.12,
                    child: Text(testDescription==null?"":testDescription,style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,),
                  )

                ],
              ),
            ),
          ),
          maxMembers==2?
          SizedBox(
            height: MediaQuery.of(context).size.height*0.01,
          ):
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          ),
          maxMembers==2?
          Center(
            child: Container(
              width : MediaQuery.of(context).size.width * 0.31,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff2f3136),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  Column(
                    children: [
                      Container(
                        child: TextField(
                          controller: teamNameController,
                          style: TextStyle(color: Colors.white70),
                          decoration: new InputDecoration(
                            fillColor: Color(0xff36393f),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff2f3136))
                            ),
                            prefixIcon: Icon(Icons.people,color: Colors.white70,),
                            labelText: "TEAM NAME",
                            labelStyle: TextStyle(color: Colors.white70),
                            errorText: autoValidate ? teamNameController.text.isEmpty? 'Value Can\'t Be Empty' : null:null,
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: Color(0xff2a2c31),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.01,
                  ),

                ],
              ),
            ),
          ):
              SizedBox(
                height: 0,
              ),
          maxMembers==2?
          SizedBox(
            height: MediaQuery.of(context).size.height*0.015,
          ):
          SizedBox(
            height: 0,
          ),
          maxMembers==1?
          Center(
            child: Container(
              width : MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff2f3136),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),

                  Container(
                      width : MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xff145cae),
                      ),
                      child: Text("STUDENT DETAILS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,)
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  Form(
                    key: _formKeyOne,
                    autovalidate: autoValidate,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextFormField(
                                controller: studentOneNameController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.perm_identity,color: Colors.white70,),
                                  labelText: "NAME",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                                validator: validateName,
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextFormField(
                                controller: studentOneUSNController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.format_list_numbered,color: Colors.white70,),
                                  labelText: "USN",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                                  validator: validateUSN,
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.02,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextFormField(
                                controller: studentOneEmailController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.email,color: Colors.white70,),
                                  labelText: "EMAIL ADDRESS",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                                validator: validateEmail,
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextFormField(
                                controller: studentOnePhoneController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.phone,color: Colors.white70,),
                                  labelText: "PHONE",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                                validator: validateMobile,
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),

                ],
              ),
            ),
          ):
          Form(
            key: _formKeyTwo,
            autovalidate: autoValidate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width : MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff2f3136),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.02,
                      ),

                      Container(
                          width : MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height*0.05,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xff145cae),
                          ),
                          child: Text("STUDENT 1 DETAILS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,)
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.015,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentOneNameController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.perm_identity,color: Colors.white70,),
                                    labelText: "NAME",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateName,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentOneUSNController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.format_list_numbered,color: Colors.white70,),
                                    labelText: "USN",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateUSN,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.015,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentOneEmailController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.email,color: Colors.white70,),
                                    labelText: "EMAIL ADDRESS",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateEmail,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentOnePhoneController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.phone,color: Colors.white70,),
                                    labelText: "PHONE",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateMobile,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.015,
                      ),

                    ],
                  ),
                ),

                Container(
                  width : MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff2f3136),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.02,
                      ),

                      Container(
                          width : MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height*0.05,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xff145cae),
                          ),
                          child:  Text("STUDENT 2 DETAILS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,)
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.015,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentTwoNameController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.perm_identity,color: Colors.white70,),
                                    labelText: "NAME",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateName,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentTwoUSNController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.format_list_numbered,color: Colors.white70,),
                                    labelText: "USN",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateUSN,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.015,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentTwoEmailController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.email,color: Colors.white70,),
                                    labelText: "EMAIL ADDRESS",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateEmail
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                child: TextFormField(
                                  controller: studentTwoPhoneController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xff36393f),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff2f3136))
                                    ),
                                    prefixIcon: Icon(Icons.phone,color: Colors.white70,),
                                    labelText: "PHONE",
                                    labelStyle: TextStyle(color: Colors.white70),
                                  ),
                                  validator: validateMobile,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                    color: Color(0xff2a2c31),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.015,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
            Center(
            child: InkWell(
    onTap: ()async=>{
      if(maxMembers==1)
    if (_formKeyOne.currentState.validate()) {
        print(studentOneUSNController.text),
         saveStudentData(),
      FirebaseFirestore.instance
            .collection("users")
        .doc(widget.TestID)
        .collection("registered")
        .add({"studentOneName": studentOneNameController.text, "studentOneUSN": studentOneUSNController.text, "studentOneEmail": studentOneEmailController.text,"studentOnePhone": studentOnePhoneController.text,}),
    Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => Instructions(widget.TestID,testName,isactive,isover,testInstructions,studentOne,studentTwo,maxMembers,questions,testTime,maxQuestions),
    )
    ),
    },
    if(maxMembers==2)
      if(teamNameController.text.isNotEmpty)
    if (_formKeyTwo.currentState.validate()) {
    print(studentOneUSNController.text),
    saveStudentData(),
      FirebaseFirestore.instance
        .collection("users")
        .doc(widget.TestID)
        .collection("registered")
        .add({"studentOneName": studentOneNameController.text, "studentOneUSN": studentOneUSNController.text, "studentOneEmail": studentOneEmailController.text,"studentOnePhone": studentOnePhoneController.text,"studentTwoName": studentTwoNameController.text, "studentTwoUSN": studentTwoUSNController.text, "studentTwoEmail": studentTwoEmailController.text,"studentTwoPhone": studentTwoPhoneController.text,}),
    Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => Instructions(widget.TestID,testName,isactive,isover,testInstructions,studentOne,studentTwo,maxMembers,questions,testTime,maxQuestions),
    )
    ),
    },
    _setAutoValidate(),
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
