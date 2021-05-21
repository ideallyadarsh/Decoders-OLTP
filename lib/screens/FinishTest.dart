import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oltp/models/StudentModel.dart';
import 'dart:html' as html;

import 'package:oltp/screens/Landing.dart';

class FinishTest extends StatefulWidget {
  String testID;
  Student studentOne;
  Student studentTwo;
  int maxMembers;
  final answerArray;
  final questionsArray;
  int maxQuestions;

  FinishTest(this.testID, this.studentOne, this.studentTwo, this.maxMembers,
      this.answerArray,this.questionsArray,this.maxQuestions);

  @override
  _FinishTestState createState() => _FinishTestState();
}

class _FinishTestState extends State<FinishTest> {
  bool submitted = false;
  bool failed = false;
  final firestoreInstance = FirebaseFirestore.instance;

  submitAnswers()async{
    setState(() {
      failed = false;
    });
    try {
      DocumentReference ref = firestoreInstance.collection("answered")
          .doc(widget.testID)
          .collection("submissions").doc();
      String docId = ref.id;
      if (widget.maxMembers == 1)
        await firestoreInstance
            .collection("answered")
            .doc(widget.testID)
            .collection("submissions")
            .doc(docId)
            .set({
          "studentOneName": widget.studentOne.studentName,
          "studentOneUSN": widget.studentOne.studentUSN,
          "studentOneEmail": widget.studentOne.studentEmail,
          "studentOnePhone": widget.studentOne.studentPhone,
          "time":DateTime.now().toUtc()
        });
      if (widget.maxMembers == 2)
        await firestoreInstance
            .collection("answered")
            .doc(widget.testID.toLowerCase())
            .collection("submissions")
            .doc(docId)
            .set({
          "studentOneName": widget.studentOne.studentName,
          "studentOneUSN": widget.studentOne.studentUSN,
          "studentOneEmail": widget.studentOne.studentEmail,
          "studentOnePhone": widget.studentOne.studentPhone,
          "studentTwoName": widget.studentTwo.studentName,
          "studentTwoUSN": widget.studentTwo.studentUSN,
          "studentTwoEmail": widget.studentTwo.studentEmail,
          "studentTwoPhone": widget.studentTwo.studentPhone,
          "time":DateTime.now().toUtc()
        });
      for (var i = 0; i < widget.maxQuestions; i++)
        await firestoreInstance
            .collection("answered")
            .doc(widget.testID)
            .collection("submissions")
            .doc(docId).collection("answers").add({
          "questionId" : widget.questionsArray[i].toString(),"answer": widget.answerArray[i].toString()
        });
      setState(() {
        submitted=true;
        failed = false;
      });
    }
    catch(error){
      print(error.toString());
      setState(() {
        failed = true;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),(){
      submitAnswers();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.push(context, MaterialPageRoute(builder: (context) => new LandingScreen())),
      child: Scaffold(
        backgroundColor: Color(0xff36393f),
        body: Column(
            children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height*0.7,
          width: MediaQuery.of(context).size.width,
          color: submitted?Colors.green:Colors.indigo,
          child: Center(
            child: submitted?Icon(Icons.check_circle_outline,size: MediaQuery.of(context).size.height*0.4,color: Colors.white70,):
            failed?Icon(Icons.error_outline,size: MediaQuery.of(context).size.height*0.4,color: Colors.white70,):
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.height*0.4,
              child: CircularProgressIndicator(
                strokeWidth: 20,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white38),
              ),
            ),
          ),
        ),
SizedBox(
  height: MediaQuery.of(context).size.height*0.05,
),
              Center(
                child: Text(submitted?"Awesome!":failed?"Submission Failed!":"Hold on!", style: TextStyle(color: Colors.white70,fontSize: 30,fontWeight: FontWeight.w500,),),
              ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        Center(
          child: Text(submitted?"Your answers have been submitted successfully.":failed?"Failed to submit your answers, Please check your Internet connection and retry.":"Your answers are being submitted.", style: TextStyle(color: Colors.white70,fontSize: 21,fontWeight: FontWeight.w500,),),
        ),
      SizedBox(
      height: MediaQuery.of(context).size.height*0.02,
      ),
        if(submitted||failed)
        Center(
          child: OutlineButton(
            splashColor: Colors.white70,
            onPressed: () {
              if(submitted)
                html.window.top.close();
              if(failed)
                submitAnswers();
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.white70,width: 3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(submitted?"Close Tab":failed?"Retry":"",style: TextStyle(color: Colors.white70,fontSize: 18,fontFamily: 'one')),
            ),
          ),
        ),
      ],
      ),
      ),
    );
  }
}
