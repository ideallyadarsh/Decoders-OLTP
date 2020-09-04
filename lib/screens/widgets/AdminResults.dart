import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oltp/models/AnswerModel.dart';
import 'package:oltp/models/StudentResultModel.dart';

class AdminResults extends StatefulWidget {
  @override
  _AdminResultsState createState() => _AdminResultsState();
}

class _AdminResultsState extends State<AdminResults> {



  prepareStudentList(String TestID)async{
    var ans = new List<Answer>(100);
    var studentResultList = new List<StudentResult>(200);
    var studentCount=0;
    var answersCount=0;
    await Firestore.instance.collection("answers").document(TestID).collection("correctanswers").getDocuments().then((value) {
      value.documents.forEach((element) {
        ans[answersCount++]= new Answer.fromJson(element.data);
      });
    });
    var tempQuesID;
    var tempOpt;
    DocumentReference SubRef = _answeredCollectionReference.document(TestID).collection("submissions").document();
    await  _answeredCollectionReference.document(TestID).collection("submissions").getDocuments().then((value) {
      value.documents.forEach((element) async{
        var score =0.0;
        var attemptedCount=0;
        await _answeredCollectionReference.document(TestID).collection("submissions").document(element.documentID).collection("answers").getDocuments().then((value) {
          value.documents.forEach((element) {
            tempQuesID=element.data['questionId'];
            tempOpt=element.data['answer'];
            if(!tempOpt.toString().contains("0"))
              attemptedCount++;
            for(var i=0;i<answersCount;i++)
            {
              if(tempQuesID==ans[i].quesID)
                if(tempOpt==ans[i].opt)
                {
                  score++;
                }
                else if(!tempOpt.toString().contains("0"))
                  score=score-1/3;
            }
          });
        });
        studentResultList[studentCount++]= new StudentResult(element.data['studentOneName'], element.data['studentOneUSN'], element.data['studentOnePhone'], element.data['studentOneEmail'], attemptedCount.toString(), score.toStringAsFixed(2));
        setState(() {
          studentsResultList=studentResultList;
          studentsCount=studentCount;
        });
      });
    });
  }
  final CollectionReference _answeredCollectionReference = Firestore.instance.collection('answered');
  var studentsResultList = new List<StudentResult>(200);
  var studentsCount=0;
  var columnHeadings = ["Sl. no.","Name","USN","Email","Phone","Attempted","Score"];
  final testIDController = TextEditingController();
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
      SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container(
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
    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),)
    ),
    ),
    SizedBox(
    width: MediaQuery.of(context).size.width*0.02,
    ),
    InkWell(
    onTap: (){
    prepareStudentList(testIDController.text);
    },
      child: Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
      color: Color(0xff145cae),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12))
      ),
      child: Center(
      child: Icon(Icons.search),
      ),
      ),
    )
    ],
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height * 0.02,
    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    for(var i=0;i<7;i++)
    Container(
    width: MediaQuery.of(context).size.width*0.12,
    child: FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(columnHeadings[i],style: TextStyle(color: Colors.white70,fontSize:25,fontWeight: FontWeight.bold,letterSpacing: 0.5))),
    ),
    ],
    ),
    ),
    for(var j=0;j<studentsCount;j++)
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    for(var i=0;i<7;i++)
    Container(
    width: MediaQuery.of(context).size.width*0.12,
    height: MediaQuery.of(context).size.height*0.04,
    child: FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(i==0?(j+1).toString():i==1?studentsResultList[j].studentName:i==2?studentsResultList[j].studentUSN.toUpperCase():i==3?studentsResultList[j].studentEmail:i==4?studentsResultList[j].studentPhone:i==5?studentsResultList[j].attemptedQuestions:studentsResultList[j].score,style: TextStyle(color: Colors.white70,fontSize:20,fontWeight: FontWeight.bold,letterSpacing: 0.5))),
    ),
    ],
    )
    ],
    ),
    );
  }
}
